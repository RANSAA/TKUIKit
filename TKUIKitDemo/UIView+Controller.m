//
//  UIView+Controller.m
//  TKUIKitDemo
//
//  Created by PC on 2021/1/4.
//  Copyright © 2021 芮淼一线. All rights reserved.
//

#import "UIView+Controller.h"

@implementation UIView (Controller)


/**
功能：获取view当前所在的Controller控制器。
如果是childViewController的view，并且将view作为subView添加到ViewControler.view中,那么获取到的控制器依然是作为主控制器的ViewControler
PS:注意与controllerFromChildController的区别
 */
- (nullable UIViewController *)controllerFromController1
{
    UIViewController *controller = nil;
    UIResponder *next = nil;
    if (self.superview) {
        NSLog(@"next name:%@",self.superview.class);
        //presentViewController
        if ([self.superview isMemberOfClass:NSClassFromString(@"UITransitionView")]) {
            next = self.nextResponder;
        }else if ([self.superview isMemberOfClass:NSClassFromString(@"UIViewControllerWrapperView")]) {//pushViewController
            next = self.nextResponder;
        }
        else{//addChildViewController
            next = self.superview.nextResponder;
        }
    }else{
        //ViewControler
        next = self.nextResponder;
    }
    while (next) {
        if ([next isKindOfClass:UIViewController.class]) {
            controller = (UIViewController *)next;
            break;
        }
        next = next.nextResponder;
    }
    return controller;
}

/**
功能：获取view当前所在的Controller控制器。
如果是childViewController的view，并且将view作为subView添加到ViewControler.view中,那么获取到的控制器将会是作为子控制器的childViewController。
PS:注意与controllerFromController的区别
*/
- (nullable UIViewController *)controllerFromChildController1
{
    UIViewController *controller = nil;
    UIResponder *next = self.nextResponder;
        while (next) {
            if ([next isKindOfClass:UIViewController.class]) {
            controller = (UIViewController *)next;
            break;
        }
        next = next.nextResponder;
    }
    return controller;
}


@end
