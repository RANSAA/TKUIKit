//
//  TKSDKCollectionViewController.h
//  TKSDKUniversal
//
//  Created by PC on 2018/10/18.
//  Copyright © 2018年 PC. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TKSDKNavigationBar.h"

/**
继承于UICollectionViewController,实现自定义导航条以及一些常用的功能（如返回，侧滑等）
使用自定义的导航条--默认是把系统的导航条给隐藏了的
使用自定义的导航调配，新页面显示可以利用PUSH与Model的方式进行
支持侧滑返回(使用系统默认的侧滑返回方式)
实现了UIGestureRecognizerDelegate代理
注意：
    1.导航条的默认高度为44，并且横竖屏不同状态可以分别设置导航条的高度，需要修改导航条的有效高度时，直接调用TKNavigationBar对应的方法即可
    2.使用CollectionView.contentInsetAdjustmentBehavior时要注意
 
PS:
    在使用contentInsetAdjustmentBehavior时一定要注意，如果将它的值设置为：UIScrollViewContentInsetAdjustmentNever时，
    使用IQKeyboardManager时，输入框不会随着键盘弹出而移动位置(系统的UICollectionViewController也会这样)，所以要注意该属性的使用

使用场景:
        静态网格时推荐优先使用该控制器

other:
        如果出现TKNavigationBar导航条被遮挡的情况，请执行[self makeNavigationBarOnTop],使TKNavigationBar始终保持在最上层。
 
*/




NS_ASSUME_NONNULL_BEGIN

@interface TKSDKCollectionViewController : UICollectionViewController <UIGestureRecognizerDelegate>
@property(nonatomic, strong, readonly, nullable) TKSDKNavigationBar * TKNavigationBar;//自定义的导航条
@property(nonatomic, assign) BOOL isEnabledTKNavigationBar;//是否开启TKNavigationBar的使用，默认开启
@property(nonatomic, assign) BOOL isEnabledSideslip;//是否开启侧滑返回，默认开启
/**
 自动更新collectionView.contentInset属性,用于调整UICollectionView相对于TKSDKNavigationBar的位置，Default YES;
 如果需要手动修改collectionView.contentInset，请先将此属性设置为NO。
 */
@property(nonatomic, assign) BOOL autoUpdateContentInset;

#pragma mark TKSDKNavigationBar默认配置区域

/**
 功能:默认配置函数。
 说明:如果直接用对应属性的seter方法去修改，会先创建然后再移出。所以如果默认不需要创建相关操作，就可以重写该方法，然后利用KVC方式修改默认属性。
 注意:重写时需要先[self super];再修改相关配置。如：
     [self setValue:@(NO) forKey:@"_isEnabledTKNavigationBar"];
 场景:主要是当前controller作为childController时，默认不需要创建TKSDKNavigationBar时，即可重写！
 可修改的Key值:
             _isEnabledTKNavigationBar  //默认是否开启TKNavigationBar
             _isEnabledSideslip         //默认是否开启侧滑返回
 */
- (void)defaultEnabledConfig;

/**
 使TKNavigationBar保持在self.view的最上层.
 PS:如果出现TKNavigationBar出现被其它控件遮挡的情况时，使用此方法使其置顶
 */
- (void)makeNavigationBarOnTop;


#pragma mark 默认基础函数区域
/**  返回函数操作 */
- (void)backAction:(id _Nonnull)sender;
/**
 当页面完全返回上一级页面后会调用该函数
 :- (void)didMoveToParentViewController:(UIViewController *)parent
 */
- (void)backDidParentControllerAction;


#pragma mark 状态栏相关显示设置
/**
 设置状态栏文字样式
 0:默认黑色
 1:白色高亮
 2:自动
*/
- (void)setStatusBarStyleType:(NSInteger)styleType;
/**  设置设备竖屏时，状态栏是否隐藏*/
- (void)setStatusBarIsHidden:(BOOL)isHidden;
/**
 设置设备横屏时，状态栏是否隐藏，默认隐藏
 PS:iOS13.0+无效，横屏时不能显示状态栏
 */
- (void)setStatusBarLandscapeIsHidden:(BOOL)isHidden;


#pragma mark 扩展UINavigationController相关方法
/**
  扩展使其等效于UINavigationController中对应的方法
  PS:如果当前控制器不在NavigationController中，则使其等效于对应present与dismiss方法
 */
- (void)pushViewController:(UIViewController *_Nullable)viewController animated:(BOOL)animated;
- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated;
- (nullable NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated;
- (nullable NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *_Nullable)viewController animated:(BOOL)animated;


#pragma mark 工具函数区域
/**
作用：解决侧滑返回时，控制器左边有Scrollview控制而引起冲突问题，导致侧滑失效问题。
   ：即可以不设置控制器中多个控件都可以同时接收同一个手势
*/
- (void)setTKPanGestureRecognizerWithScrollView:(UIScrollView *_Nullable)scrollView;


@end

NS_ASSUME_NONNULL_END
