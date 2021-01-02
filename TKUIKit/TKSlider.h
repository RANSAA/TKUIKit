//
//  TKSlider.h
//  TKUIKitDemo
//
//  Created by PC on 2020/12/31.
//  Copyright © 2020 芮淼一线. All rights reserved.
//

/**
 功能：
    1.解决使用thumbTintColor时靠边有间隙的问题
    2.设置thumb的图片为[UIImage new]可以达到隐藏thumb的效果
    3.通过新增bufferView以达到显示缓冲进度条
    4.通过代理实现点击与拖动回调同步功能
 
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
/** 缓冲条,默认不显示 */
@property (nonatomic, strong) UIView *bufferView;
/** 是否显示缓冲条，默认不显示 */
@property (nonatomic, assign) BOOL showBufferView;
/** bufferView的值，范围:slider.min ~ slider.max */
@property (nonatomic, assign) CGFloat bufferValue;

/** thumb滑动到首尾时，thumb的中心是否与首尾边对齐 */
@property (nonatomic, assign) BOOL centerThumb;

/** 是否允许点击 */
@property (nonatomic, assign) BOOL isClick;
@property (nonatomic, weak) id<TKSilderDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
