//
//  TKPhotoItem.m
//  TKUIKitDemo
//
//  Created by PC on 2021/8/29.
//  Copyright © 2021 芮淼一线. All rights reserved.
//

#import "TKPhotoItem.h"

@implementation TKPhotoItem

//获取视频预览图(0.0, 30)
- (UIImage *)videoPreviewImage
{
    CMTime time = CMTimeMakeWithSeconds(0.0, 30);// 1.0为截取视频1.0秒处的图片，30为每秒30帧
    return  [self videoPreviewImageWith:time];
}


//获取视频指定位置预览图片
- (UIImage *)videoPreviewImageWith:(CMTime)time
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:self.originalUrl options:nil];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;// 截图的时候调整到正确的方向
    CGImageRef cgImage = [imageGenerator copyCGImageAtTime:time actualTime:nil error:nil];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImage;
}

@end

@implementation TKPhotoIndicator

- (BOOL)isStop
{
    if (self.count == self.index) {
        return YES;
    }
    return NO;
}
//index+1
- (void)next
{
    _index += 1;
}

@end

@implementation TKPhotoConfigurator

@end
