//
//  TKSlider.h
//  TKUIKitDemo
//
//  Created by PC on 2020/12/31.
//  Copyright © 2020 芮淼一线. All rights reserved.
//

/**
 功能：
    1.继承UISlider实现点击功能
    2.实现thumb滑动到首尾时thumb中心点与首尾位置对齐
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TKSlider;
@protocol TKSilderDelegate <NSObject>
@optional
/** slider.value发生变化回调*/
- (void)TKSlider:(TKSlider *)slider changedValue:(CGFloat)value;
/** slider点击或者滑动结束时回调*/
- (void)TKSlider:(TKSlider *)slider clickedValue:(CGFloat)value;

/** 开始点击或者滑动slider*/
- (void)TKSliderTouchBegan:(TKSlider *)slider;
/** 结束点击或者滑动slider */
- (void)TKSliderTouchEnd:(TKSlider *)slider;

@end

@interface TKSlider : UISlider
/**thumb滑动到首尾时是否居中 */
@property (nonatomic, assign) BOOL isThumbCenter;
/** 是否允许点击 */
@property (nonatomic, assign) BOOL isClick;
@property (nonatomic, weak) id<TKSilderDelegate> delegate;

/** 缓冲条,默认不显示 */
@property (nonatomic, strong) UIView *bufferView;
/** 是否显示缓冲条，默认不显示 */
@property (nonatomic, assign) BOOL showBufferView;
/** bufferView的值，范围 0.0~1.0 */
@property (nonatomic, assign) CGFloat bufferValue;

@end

NS_ASSUME_NONNULL_END
