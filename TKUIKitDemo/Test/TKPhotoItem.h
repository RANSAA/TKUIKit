//
//  TKPhotoItem.h
//  TKUIKitDemo
//
//  Created by PC on 2021/8/29.
//  Copyright © 2021 芮淼一线. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TKPhotoItemType){
    TKPhotoItemTypeImage = 0,   //UIImage
    TKPhotoItemTypeLivePhoto,   //PHLivePhoto
    TKPhotoItemTypeVideo        //视频
};

@interface TKPhotoItem : NSObject
@property(nonatomic, strong) NSString *identifier;
@property(nonatomic, assign) TKPhotoItemType type;
@property(nonatomic, strong) NSURL *originalUrl;
@property(nonatomic, strong) NSURL *url;
@property(nonatomic, strong) NSString *originalPath;
@property(nonatomic, strong) NSString *path;

@property(nonatomic, strong, nullable) NSArray *urlLivePhoto;//只有type为TKPhotoItemTypeLivePhoto时才有值

@property(nonatomic, strong) UIImage *image;//UIImage或PHLivePhoto显示压缩的单帧图片
@property(nonatomic, strong, nullable) id object;//UIImage或者PHLivePhoto对象


//获取视频预览图(0.0, 30)
- (UIImage *)videoPreviewImage;
//获取视频指定位置预览图片
- (UIImage *)videoPreviewImageWith:(CMTime)time;

@end



@interface TKPhotoIndicator : NSObject
@property(assign) NSInteger count;
@property(assign) NSInteger index;
@property(assign, readonly) BOOL isStop;//是否结束

//index+1
- (void)next;

@end


//配置
@interface TKPhotoConfigurator : NSObject
@property(nonatomic, assign) CGFloat quality; //图片压缩质量,0.0~1.0.
@end

NS_ASSUME_NONNULL_END
