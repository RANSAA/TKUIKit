//
//  UIApplication+TKSDK.h
//  TKSDKUniversal
//
//  Created by PC on 2019/12/23.
//  Copyright © 2019 PC. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (TKSDK)

/**
获取keyWindow,适配iOS13.0+
PS:如果需要实现iPad多屏处理，最好是使用SceneDelegate管理Window
*/
+ (UIWindow*)TK_keyWindow;

/**
 获取当前显示的视图控制器
 */
+ (UIViewController *)TK_getCurrentController;


@end

NS_ASSUME_NONNULL_END
