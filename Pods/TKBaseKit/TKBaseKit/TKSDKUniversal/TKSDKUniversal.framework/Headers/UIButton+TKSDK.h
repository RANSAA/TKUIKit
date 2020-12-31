//
//  UIButton+TKSDK.h
//  testFor
//
//  Created by Mac on 2019/6/15.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (TKSDK)
/**
 设置标题title
 ⚠️严重警告:不要扩展名为setTitle:的方法，因为该扩展方法无效，是一个未知的bug。
 */
- (void)setTitleText:(NSString *)title;
/** 设置字体颜色 */
- (void)setTitleColor:(UIColor *)color;
/** 设置image  */
- (void)setImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
