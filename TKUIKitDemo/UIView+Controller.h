//
//  UIView+Controller.h
//  TKUIKitDemo
//
//  Created by PC on 2021/1/4.
//  Copyright © 2021 芮淼一线. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Controller)
/**
功能：获取view当前所在的Controller控制器。
如果是childViewController的view，并且将view作为subView添加到ViewControler.view中,那么获取到的控制器依然是作为主控制器的ViewControler
PS:注意与controllerFromChildController的区别
 */
- (nullable UIViewController *)controllerFromController1;

/**
功能：获取view当前所在的Controller控制器。
如果是childViewController的view，并且将view作为subView添加到ViewControler.view中,那么获取到的控制器将会是作为子控制器的childViewController。
PS:注意与controllerFromController的区别
*/
- (nullable UIViewController *)controllerFromChildController1;
@end

NS_ASSUME_NONNULL_END
