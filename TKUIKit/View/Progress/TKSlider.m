//
//  TKSlider.m
//  TKUIKitDemo
//
//  Created by PC on 2020/12/31.
//  Copyright © 2020 芮淼一线. All rights reserved.
//

#import "TKSlider.h"

@interface TKSlider ()<UIGestureRecognizerDelegate>
@property(nonatomic, strong)NSLayoutConstraint *layWidth;
@property(nonatomic, assign, readonly)BOOL isCurrentThumbImage;//检查当前currentThumbImage是否是UIimage
@end

@implementation TKSlider

//滑块的点击轴换位置--实际上是一个触摸方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self began];
    if (_isClick) {
        CGFloat min = self.minimumValue;
        CGFloat max = self.maximumValue;
        CGRect t = [self trackRectForBounds: [self bounds]];
        //将点击位置转化到进度条的位置，并其值
        CGFloat pointX = [[touches anyObject] locationInView: self].x;
        CGFloat clickWidth = pointX-t.origin.x;
        clickWidth = clickWidth<0.0?0.0:(clickWidth>t.size.width?t.size.width:clickWidth);
        CGFloat v  = clickWidth/t.size.width*(max-min) + min;
        [self setValue: v];
        
//        float v = [self minimumValue] + ([[touches anyObject] locationInView: self].x - t.origin.x - 4) * (([self maximumValue]-[self minimumValue]) / (t.size.width - 8));
//        v = v>max?max:(v<min?min:v);
//        [self setValue: v];
        
    }
    [super touchesBegan: touches withEvent: event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (!_isClick) {
        [self end];
    }
}


/**
 实现thumb滑动到首尾时thumb中心点与首尾位置对齐
 */
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    CGFloat offX = 4;
    CGFloat offY = 30;
    if (self.isCurrentThumbImage) {
        if (_centerThumb) {
            offX = self.currentThumbImage.size.width;
        }else{
            offX  = 0;
        }
        offY = self.currentThumbImage.size.height;
    }else{
        if (_centerThumb) {
            offX = offY;
        }
    }
    rect.origin.x = rect.origin.x - offX/2.0 ;
    rect.size.width = rect.size.width + offX;
    return CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:value], offX/2.0 , offY/2.0);
}


- (BOOL)isCurrentThumbImage
{
    if (!self.currentThumbImage) {
        return NO;
    }else{
        if ([self.currentThumbImage isMemberOfClass:NSClassFromString(@"_UIResizableImage")]) {
            return NO;
        }
        return YES;;
    }
}


#pragma mark action

- (void)setDelegate:(id<TKSilderDelegate>)delegate
{
    _delegate = delegate;
    if (_delegate) {
        [self addGestureRecognizer];
    }
}

- (void)addGestureRecognizer
{
    [self addTarget:self action:@selector(changeValueAction) forControlEvents:UIControlEventValueChanged];
    [self addTarget:self action:@selector(touchUpAction) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(touchUpAction) forControlEvents:UIControlEventTouchUpOutside];
}

- (void)setIsClick:(BOOL)isClick
{
    _isClick = isClick;
    if (_isClick) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
        UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longAction:)];
        [self addGestureRecognizer:longGes];
    }
}

- (void)longAction:(UILongPressGestureRecognizer *)longGes
{
    if (_isClick) {
        if (longGes.state == UIGestureRecognizerStateEnded) {
            [self clickAction];
            [self end];
        }
    }
}

- (void)tapAction
{
    if (_isClick) {
        [self clickAction];
        [self end];
    }
}

- (void)touchUpAction
{
    [self clickAction];
    if (_isClick) {
        [self end];
    }
}


- (void)began
{
    if ([self.delegate respondsToSelector:@selector(TKSliderTouchBegan:)]) {
        [self.delegate TKSliderTouchBegan:self];
    }
}

- (void)end
{
    if ([self.delegate respondsToSelector:@selector(TKSliderTouchEnd:)]) {
        [self.delegate TKSliderTouchEnd:self];
    }
}

- (void)clickAction
{
    [self changeValueAction];
    if ([self.delegate respondsToSelector:@selector(TKSlider:clickedValue:)]) {
        [self.delegate TKSlider:self clickedValue:self.value];
    }
}

- (void)changeValueAction
{
    if ([self.delegate respondsToSelector:@selector(TKSlider:changedValue:)]) {
        [self.delegate TKSlider:self changedValue:self.value];
    }
}

#pragma mark 添加缓冲条
- (UIView *)bufferView
{
    if (!_bufferView) {
        _bufferView = [[UIView alloc] init];
        _bufferView.userInteractionEnabled = NO;
        if (@available(iOS 13.0, *)) {
            _bufferView.backgroundColor = UIColor.systemGray2Color;
        } else {
            _bufferView.backgroundColor = [UIColor colorWithRed:174/255.0 green:174/255.0 blue:178/255.0 alpha:1.0];
        }
        _bufferView.tag = 9527;
        [self insertSubview:_bufferView atIndex:0];
    }
    return _bufferView;;
}

- (void)setupBufferView
{
    if (_showBufferView) {
        [self updateBufferViewFrame];
        [self fixedBufferViewLocation];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setupBufferView];
}

- (void)setBufferValue:(CGFloat)bufferValue
{
    _bufferValue = bufferValue;
    [self updateBufferViewFrame];
}

- (void)updateBufferViewFrame
{
    CGFloat s = _bufferValue/(self.maximumValue-self.minimumValue);
    s = s<0.0?0.0:(s>1.0?1.0:s);
    CGRect frame = [self trackRectForBounds: [self bounds]];
    frame.size.width *= s;
    _bufferView.frame = frame;
}

#pragma mark 固定_bufferView的层级
- (void)fixedBufferViewLocation
{
    if (_bufferView.tag == 9527) {
        NSInteger index = 0;
        NSArray *views = self.subviews;
        for (UIView *vi in views) {
            if ([vi isMemberOfClass:UIImageView.class]) {
                index++;
            }
        }
        _bufferView.tag = 0;
        [self insertSubview:_bufferView atIndex:index];
    }
}


@end
