//
//  TKSlider.m
//  TKUIKitDemo
//
//  Created by PC on 2020/12/31.
//  Copyright © 2020 芮淼一线. All rights reserved.
//

#import "TKSlider.h"

@interface TKSlider ()
@property(nonatomic, assign)NSInteger isAddThumb;
@property(nonatomic, strong)NSLayoutConstraint *layWidth;
@end

@implementation TKSlider


//滑块的点击轴换位置--实际上是一个触摸方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self began];

    CGFloat width = 30;
    if (_isAddThumb) {
        width = self.currentThumbImage.size.width;
    }
    if (_isClick) {
        CGFloat min = self.minimumValue;
        CGFloat max = self.maximumValue;
        CGRect t = [self trackRectForBounds: [self bounds]];
        float v = [self minimumValue] + ([[touches anyObject] locationInView: self].x - t.origin.x - width/2.0) * (([self maximumValue]-[self minimumValue]) / (t.size.width - width));
        v = v>max?max:(v<min?min:v);
        [self setValue: v];
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
    if (_isThumbCenter) {
        CGFloat width = 31;
        CGFloat height = 31;
        if (_isAddThumb) {
            width = self.currentThumbImage.size.width;
            height = self.currentThumbImage.size.height;
        }
        rect.origin.x = rect.origin.x - width/2.0 ;
        rect.size.width = rect.size.width + width;
        return CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:value], width/2.0 , height/2.0);
    }
    return [super thumbRectForBounds:bounds trackRect:rect value:value];
}

- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state
{
    [super setThumbImage:image forState:state];
    _isAddThumb = YES;
}

- (void)setShowThumb:(BOOL)showThumb
{
    _showThumb = showThumb;
    UIImage *image = self.currentThumbImage;
    if (!showThumb) {
        image = [UIImage new];
    }
    [self setThumbImage:image forState:UIControlStateNormal];
    [self setThumbImage:image forState:UIControlStateHighlighted];
}
    

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

- (void)setupBufferView
{
    if (_showBufferView && !_bufferView) {
        _bufferView = [[UIView alloc] init];
        _bufferView.userInteractionEnabled = NO;
        if (@available(iOS 13.0, *)) {
            _bufferView.backgroundColor = UIColor.systemGray2Color;
        } else {
            _bufferView.backgroundColor = [UIColor colorWithRed:174/255.0 green:174/255.0 blue:178/255.0 alpha:1.0];
        }
        [self insertSubview:_bufferView atIndex:1];
        _bufferView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *leftAnchor = [_bufferView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:0];
        NSLayoutConstraint *heightAnchor = [_bufferView.heightAnchor constraintEqualToConstant:3.0];
        NSLayoutConstraint *centerAncher = [_bufferView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:1];
        NSLayoutConstraint *widthAchor = [_bufferView.widthAnchor constraintEqualToConstant:0];
        leftAnchor.active = YES;
        centerAncher.active = YES;
        heightAnchor.active = YES;
        widthAchor.active = YES;
        self.layWidth = widthAchor;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setNeedsBufferView];
        });
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setupBufferView];
}

- (void)setBufferValue:(CGFloat)bufferValue
{
    _bufferValue = bufferValue<0.0?0.0:(bufferValue>1.0?1.0:bufferValue);
    [self setNeedsBufferView];
}

- (void)setNeedsBufferView
{
    CGFloat width = self.bounds.size.width;
    self.layWidth.constant = width*_bufferValue;
}

- (void)dealloc
{
    NSLog(@"dellll...");
}

@end
