//
//  PHPickerVC.m
//  TKUIKitDemo
//
//  Created by PC on 2021/8/28.
//  Copyright © 2021 芮淼一线. All rights reserved.
//

#import "PHPickerVC.h"
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>

#import "TKPhotoItem.h"
#import "PrewPhotosVC.h"


API_AVAILABLE(ios(14))
@interface PHPickerVC ()<PHPickerViewControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic, strong) PHPickerViewController *pickerVC;
@property(nonatomic, strong) PHLivePhotoView *livePhoneView;
@property(nonatomic, strong) UIImageView *preView;
@property(nonatomic, strong) TKPhotoConfigurator *config;


@property(nonatomic, strong) PrewPhotosVC *prewVC;
@end

@implementation PHPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 以下 API 仅为 iOS14 only

    self.config = [[TKPhotoConfigurator alloc] init];
    self.config.quality = 0.1;

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 320, 100, 100);
    [btn setText:@"openPHPicker"];
    [btn addTarget:self action:@selector(btnOpenPHPickerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    UIButton *liveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    liveBtn.frame = CGRectMake(100, 420, 100, 100);
    [liveBtn setText:@"livePhoto"];
    [liveBtn addTarget:self action:@selector(btnOpenLiveAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:liveBtn];


    PHLivePhotoView *vi = [[PHLivePhotoView alloc] init];

    self.livePhoneView = [[PHLivePhotoView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    [self.view addSubview:self.livePhoneView];
    self.livePhoneView.backgroundColor = UIColor.grayColor;

    self.preView = [[UIImageView alloc] initWithFrame:CGRectMake(28, 100, 100, 100)];
    self.preView.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.preView];


    PrewPhotosVC *vc = [[PrewPhotosVC alloc] init];
    vc.modalPresentationStyle = 0;
    self.prewVC = vc;

}

- (void)btnOpenPHPickerAction
{
    [self setupPicker];
}

- (void)btnOpenLiveAction
{
    UIImage *image = [UIImage imageWithContentsOfFile:@"file:///Users/kimi/Library/Developer/CoreSimulator/Devices/8A796312-523B-4B3F-9B08-610F6BD98F64/data/Containers/Shared/AppGroup/BC921B36-F878-4292-9545-D783E1618D23/File%20Provider%20Storage/photospicker/version=1&uuid=E2C66E13-119E-455D-8182-B6AB072A97AE&mode=compatible.pvt/IMG_0019.JPG"];
    NSArray *ary = @[[NSURL URLWithString:@"file:///Users/kimi/Library/Developer/CoreSimulator/Devices/8A796312-523B-4B3F-9B08-610F6BD98F64/data/Containers/Shared/AppGroup/BC921B36-F878-4292-9545-D783E1618D23/File%20Provider%20Storage/photospicker/version=1&uuid=E2C66E13-119E-455D-8182-B6AB072A97AE&mode=compatible.pvt/IMG_0019.JPG"],
    [NSURL URLWithString:@"file:///Users/kimi/Library/Developer/CoreSimulator/Devices/8A796312-523B-4B3F-9B08-610F6BD98F64/data/Containers/Shared/AppGroup/BC921B36-F878-4292-9545-D783E1618D23/File%20Provider%20Storage/photospicker/version=1&uuid=E2C66E13-119E-455D-8182-B6AB072A97AE&mode=compatible.pvt/IMG_0019.MOV"]
    ];
    [PHLivePhoto requestLivePhotoWithResourceFileURLs:ary placeholderImage:image targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill resultHandler:^(PHLivePhoto * _Nullable livePhoto, NSDictionary * _Nonnull info) {
        NSLog(@"calss:%@",livePhoto);


        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.livePhoneView.livePhoto = livePhoto;
//            [self.livePhoneView startPlaybackWithStyle:0];
        }];

    }];

}


- (void)setupPicker API_AVAILABLE(ios(14))
{
//    [PHPhotoLibrary.sharedPhotoLibrary presentLimitedLibraryPickerFromViewController:self];

    PHPickerFilter *filters = [PHPickerFilter anyFilterMatchingSubfilters:@[PHPickerFilter.imagesFilter,PHPickerFilter.livePhotosFilter,PHPickerFilter.videosFilter]];

//    filters = @[PHPickerFilter.imagesFilter];

    PHPickerConfiguration *configuration = [[PHPickerConfiguration alloc] init];
//    configuration.filter = [PHPickerFilter imagesFilter]; // 可配置查询用户相册中文件的类型，支持三种
//    configuration.filter = [PHPickerFilter videosFilter]; // 可配置查询用户相册中文件的类型，支持三种
    configuration.filter = filters;

    configuration.selectionLimit = 0; // 默认为1，为0时表示可多选。

    PHPickerViewController *picker = [[PHPickerViewController alloc] initWithConfiguration:configuration];
    picker.modalPresentationStyle = UIModalPresentationOverFullScreen;
    picker.delegate = self;
    // picker vc，在选完图片后需要在回调中手动 dismiss
    [self presentViewController:picker animated:YES completion:^{
//        NSLog(@":%@",self.presentationController);
//        NSLog(@"OK:%@",self.presentedViewController);
//        NSLog(@":%@",self.presentingViewController);
    }];

}



#pragma mark PHPickerViewControllerDelegate
- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results API_AVAILABLE(ios(14))
{
    [picker dismissViewControllerAnimated:YES completion:nil];

      if (!results || !results.count) {
          return;
      }

    NSMutableArray *list = [[NSMutableArray alloc] init];
    TKPhotoIndicator *indicator = [[TKPhotoIndicator alloc] init];
    indicator.count = results.count;

    self.prewVC.dataAry = list;

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 5;


    __weak typeof(self) weakSelf = self;
    for (PHPickerResult *result in results) {
//        NSItemProvider *itemProvider = result.itemProvider;
//        TKPhotoItem *item = [TKPhotoItem new];
//        [list addObject:item];
//        NSLog(@"itemProvider:%@",itemProvider.registeredTypeIdentifiers);

        [queue addOperationWithBlock:^{
            NSItemProvider *itemProvider = result.itemProvider;
            TKPhotoItem *item = [TKPhotoItem new];
            [list addObject:item];
            NSLog(@"itemProvider:%@",itemProvider.registeredTypeIdentifiers);

            [weakSelf assetItemProvider:itemProvider item:item indicator:indicator handler:^(BOOL stop){
                if (stop) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                        [weakSelf presentViewController:weakSelf.prewVC animated:YES completion:nil];
                        if (item.type == TKPhotoItemTypeLivePhoto) {
                            self.livePhoneView.livePhoto = item.object;
                            [self.livePhoneView startPlaybackWithStyle:PHLivePhotoViewPlaybackStyleUndefined];
                        }
                    }];
                }
            }];
        }];


//        [self assetItemProvider:itemProvider item:item indicator:indicator handler:^(BOOL stop) {
//            if (stop) {
//                NSLog(@"end....");
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self presentViewController:self.prewVC animated:YES completion:nil];
//                });
//            }
//        }];


    }

}





- (void)assetItemProvider:(NSItemProvider *)itemProvider  item:(TKPhotoItem *)photosItem indicator:(TKPhotoIndicator *)indicator handler:(void(^)(BOOL stop))handler               API_AVAILABLE(ios(14))
{
    NSString *identifier = [self identifierItemProvider:itemProvider photosItem:photosItem];
    [self itemProvider:itemProvider photosItem:photosItem callBack:^{
        if ([identifier isEqualToString:UTTypeMovie.identifier]) {
            photosItem.type = TKPhotoItemTypeVideo;
            photosItem.path = photosItem.originalPath;
            photosItem.url = photosItem.originalUrl;
            if ([NSFileManager.defaultManager fileExistsAtPath:photosItem.originalPath]) {
                [indicator next];
                if (indicator.isStop) {
                    if (handler) {
                        handler(YES);
                    }
                }
            }else{
                //会生成缓存文件,但是会立即删除, 这个url不能直接提供给用户使用，应为他对应的临时资源会被立即删除  run setp 1
                [itemProvider loadFileRepresentationForTypeIdentifier:identifier completionHandler:^(NSURL * _Nullable url, NSError * _Nullable error) {
                    [indicator next];
                    if (indicator.isStop) {
                        if (handler) {
                            handler(YES);
                        }
                    }
//                    NSLog(@"tmp url:%@",url.absoluteString);
                }];
            }
        }else{
            if ([itemProvider canLoadObjectOfClass:PHLivePhoto.class]) {
                photosItem.type = TKPhotoItemTypeLivePhoto;
                NSString *pvtPath = [photosItem.originalPath stringByDeletingPathExtension];
                pvtPath = [pvtPath stringByAppendingPathExtension:@"pvt"];
                NSLog(@"pvtPath:%@",pvtPath);
                NSFileManager *fm = NSFileManager.defaultManager;
                if ([NSFileManager.defaultManager fileExistsAtPath:pvtPath]) {
                    NSDirectoryEnumerator *enumerator = [fm enumeratorAtPath:pvtPath];
                    NSString *name = nil;
                    NSString *jpgPath, *movPath = nil;
                    NSURL *jpgUrl, *movUrl = nil;
                    while ((name = [enumerator nextObject]) != nil) {
                        if ([name.pathExtension isEqualToString:@"MOV"]) {
                            movPath = [pvtPath stringByAppendingPathComponent:name];

                            NSString *tmp = [NSString stringWithFormat:@"%@%@",@"file://",movPath];
                            tmp = [tmp stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                            movUrl = [NSURL URLWithString:tmp];
                        }else if ([name.pathExtension isEqualToString:@"JPG"]) {
                            jpgPath = [pvtPath stringByAppendingPathComponent:name];

                            NSString *tmp = [NSString stringWithFormat:@"%@%@",@"file://",jpgPath];
                            tmp = [tmp stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                            jpgUrl = [NSURL URLWithString:tmp];
                        }
                    }

                    //需要压缩
                    UIImage *image = [UIImage imageWithContentsOfFile:jpgPath];
                    photosItem.image = image;

                    NSLog(@"movUrl:%@",movUrl);
                    NSLog(@"jpgUrl:%@",jpgUrl);

                    photosItem.urlLivePhoto = @[movUrl,jpgUrl];
                    [PHLivePhoto requestLivePhotoWithResourceFileURLs:photosItem.urlLivePhoto placeholderImage:image targetSize:image.size contentMode:PHImageContentModeAspectFill resultHandler:^(PHLivePhoto * _Nullable livePhoto, NSDictionary * _Nonnull info) {
                        photosItem.object = livePhoto;
                        NSLog(@"calss:%@",livePhoto);


//                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                            self.livePhoneView.livePhoto = livePhoto;
//                            [self.livePhoneView startPlaybackWithStyle:0];
//                        }];

                        [indicator next];
                        if (indicator.isStop) {
                            if (handler) {
                                handler(YES);
                            }
                        }
                    }];


//                    
//                    [indicator next];
//                    if (indicator.isStop) {
//                        if (handler) {
//                            handler(YES);
//                        }
//                    }
                }else{
                    [itemProvider loadObjectOfClass:PHLivePhoto.class completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
                        photosItem.object = object;
                        //可以更新pvl文件url
                        photosItem.url = photosItem.originalUrl;
                        photosItem.path = photosItem.originalPath;

                        NSLog(@"item url:%@",photosItem.originalUrl);

                        [indicator next];
                        if (indicator.isStop) {
                            if (handler) {
                                handler(YES);
                            }
                        }
                    }];
                }
            }else{
                photosItem.type = TKPhotoItemTypeImage;
                if ([NSFileManager.defaultManager fileExistsAtPath:photosItem.originalPath]) {
                    if ([NSFileManager.defaultManager fileExistsAtPath:photosItem.path]) {
                        NSData *data = [[NSData alloc] initWithContentsOfFile:photosItem.path];
                        UIImage *image = [self decoderWithImageData:data];
                        photosItem.object = image;
                        photosItem.image = image;
                    }else{
                        NSData *data = [[NSData alloc] initWithContentsOfFile:photosItem.originalPath];
                        NSData *encoderData = [self encoderWithImageData:data];
                        UIImage *image = [self decoderWithImageData:encoderData];
                        photosItem.object = image;
                        photosItem.image = image;

                        [encoderData writeToFile:photosItem.path atomically:NO];
                    }

                    [indicator next];
                    if (indicator.isStop) {
                        if (handler) {
                            handler(YES);
                        }
                    }
                }else{
                    [itemProvider loadDataRepresentationForTypeIdentifier:identifier completionHandler:^(NSData * _Nullable data, NSError * _Nullable error) {
                        NSData *encoderData = [self encoderWithImageData:data];
                        UIImage *image = [self decoderWithImageData:encoderData];
                        photosItem.object = image;
                        photosItem.image = image;

                        [indicator next];
                        if (indicator.isStop) {
                            if (handler) {
                                handler(YES);
                            }
                        }

                        [encoderData writeToFile:photosItem.path atomically:NO];
                    }];
                }


            }
        }
    }];

}


- (NSString *)identifierItemProvider:(NSItemProvider *)itemProvider photosItem:(TKPhotoItem*)photosItem API_AVAILABLE(ios(14))
{
//    NSString *tmp =  (NSString *)kUTTypeImage;
    NSString *identifier = @"";
    if ([itemProvider hasItemConformingToTypeIdentifier:UTTypeImage.identifier]) {
        identifier = UTTypeImage.identifier;
    }
    if ([itemProvider hasItemConformingToTypeIdentifier:UTTypeHEIC.identifier]) {
        identifier = UTTypeHEIC.identifier;
    }
    if ([itemProvider hasItemConformingToTypeIdentifier:UTTypeLivePhoto.identifier]) {
        identifier = UTTypeLivePhoto.identifier;
    }
    if ([itemProvider hasItemConformingToTypeIdentifier:UTTypeMovie.identifier]) {
        identifier = UTTypeMovie.identifier;
    }
    photosItem.identifier = identifier;
    return identifier;
}

- (void)itemProvider:(NSItemProvider *)itemProvider photosItem:(TKPhotoItem*)photosItem callBack:(void(^)(void))callBack
{
    //不会生成缓存文件， 拿到缓存的url
    [itemProvider loadItemForTypeIdentifier:photosItem.identifier options:nil completionHandler:^(__kindof id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
        if ([item isKindOfClass:NSURL.class]) {
            NSURL *url = item;
            photosItem.originalUrl = url;
            photosItem.url = [self encoderUrl:url];

            NSString *path = [url.absoluteString stringByRemovingPercentEncoding];
            path = [path stringByReplacingOccurrencesOfString:@"file://" withString:@""];
            photosItem.originalPath = path;
            photosItem.path = [self encoderUrl:path];
        }
        if (callBack) {
            callBack();
        }
    }];
}

//获取编码之后的url或path
- (id)encoderUrl:(id)obj
{
    NSString *path = nil;
    if ([obj isKindOfClass:NSString.class]) {
        path = (NSString *)obj;
        NSString *extension = [path pathExtension];
        path = [path stringByDeletingPathExtension];
        path = [path stringByAppendingString:@".encoder"];
        path = [path stringByAppendingPathExtension:extension];
        return path;
    }else if ([obj isKindOfClass:NSURL.class]){
        path = ((NSURL *)obj).absoluteString;
        NSString *extension = [path pathExtension];
        path = [path stringByDeletingPathExtension];
        path = [path stringByAppendingString:@".encoder"];
        path = [path stringByAppendingPathExtension:extension];
        return [NSURL URLWithString:path];
    }
    return obj;
}

- (BOOL)checkFile:(NSString *)path
{
    NSFileManager *fm = NSFileManager.defaultManager;
    if ([fm fileExistsAtPath:path]) {
        return YES;
    }
    return NO;
}


//编码压缩
- (NSData *)encoderWithImageData:(NSData *)imageData
{
    YYImageEncoder *jpegEncoder = [[YYImageEncoder alloc] initWithType:YYImageTypeJPEG];
    jpegEncoder.quality = self.config.quality;
    [jpegEncoder addImageWithData:imageData duration:0];
    NSData *enData = [jpegEncoder encode];
    return enData;

//
//    //SDWebImage压缩图片不适合，适用于在指定场景压缩
//    UIImage *image = [UIImage imageWithData:imageData];
//    image = [SDImageCoderHelper decodedImageWithImage:image];
//    image = [SDImageCoderHelper decodedAndScaledDownImageWithImage:image limitBytes:4*imageData.length*self.config.quality];
//    NSData *data = UIImageJPEGRepresentation(image, 1.0);
//    return data;
}

//imageDate解码
- (UIImage *)decoderWithImageData:(NSData *)imageData
{
    YYImageDecoder *decoder = [YYImageDecoder decoderWithData:imageData scale:1.0];
    UIImage *image = [decoder frameAtIndex:0 decodeForDisplay:YES].image;

//    UIImage *image = [UIImage imageWithData:imageData];

    return image;
}

- (void)dealloc
{
    NSLog(@"dealloc... PHPicker.");
}




@end
