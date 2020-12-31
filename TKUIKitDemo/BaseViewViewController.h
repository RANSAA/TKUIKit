//
//  BaseViewViewController.h
//  TKUIKitDemo
//
//  Created by PC on 2020/12/31.
//  Copyright © 2020 芮淼一线. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewViewController : UIViewController
+ (instancetype)createVC;
+ (instancetype)createVCFromStory;
@end

NS_ASSUME_NONNULL_END
