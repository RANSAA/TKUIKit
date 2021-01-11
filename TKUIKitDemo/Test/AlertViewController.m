//
//  AlertViewController.m
//  TKUIKitDemo
//
//  Created by PC on 2021/1/3.
//  Copyright © 2021 芮淼一线. All rights reserved.
//

#import "AlertViewController.h"
#import "TKAlertController.h"
#import "TKSystemPhotoPicker.h"
#import "TKSimplePickerView.h"
#import "TKDatePickerView.h"


@interface AlertViewController ()
@property(nonatomic, strong) TKSystemPhotoPicker *picker1;
@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIColor *bgColor = [UIColor TKLightColor:UIColor.whiteColor darkColor:UIColor.blackColor];
    self.view.backgroundColor = bgColor;
}

- (void)setupUI
{
    NSMutableArray *titleAry = @[].mutableCopy;
    [titleAry addObject:@"alert1"];
    [titleAry addObject:@"alert2"];
    [titleAry addObject:@"alert sys"];
    [titleAry addObject:@"alert sys dolag"];
    [titleAry addObject:@"alert MB"];
    [titleAry addObject:@"alert MB dolag"];
    [titleAry addObject:@"photo 相册"];
    [titleAry addObject:@"photo 相机"];
    [titleAry addObject:@"SimplePicker"];
    [titleAry addObject:@"DatePicker"];
    
    NSInteger offX = 44;//244
    NSInteger offY = 120;//+60
    for (NSInteger i=0; i<titleAry.count; i++) {
        offX = i%2==0?44:210;
        NSInteger s = i/2;
        offY = 100+s*60;
        CGRect rect = CGRectMake(offX, offY, 112, 44);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = rect;
        btn.tag = i+1;
        [btn setTitleText:titleAry[i]];
        [btn addTarget:self action:@selector(btnAlertAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
}

- (void)btnAlertAction:(UIButton *)btn
{
    WeakSelf
    switch (btn.tag) {
        case 1:
        {
            TKAlertView *alert = [TKAlertView TKAlertViewWithTitle:@"title" text:@"TKAlertViewWithTitle"];
            alert.blockDone = ^{
               NSLog(@"done..");
            };
            alert.blockCancel = ^{
               NSLog(@"cacnel...");
            };
            [alert.btnDone setTitleText:@"Done"];
        }
            break;
        case 2:{
            TKAlertView *alert = [TKAlertView TKAlertViewDialogWithTitle:@"Title" text:@"TK\nAlertView\nDialog\nWithTitle"];
            alert.blockDone = ^{
               NSLog(@"done..");
            };
            alert.blockCancel = ^{
               NSLog(@"cacnel...");
            };
        }
            break;
        case 3:{
            TKAlertController *alert = [TKAlertController TKAlertViewShow:self.view Title:@"Title" text:@"Msg"];
            alert.blockDone = ^(id value) {
                UIAlertAction *action = (UIAlertAction *)value;
                NSLog(@"index:%ld  class:%@",action.tag,action);
            };
        }
            break;
        case 4:{
            TKAlertController *alert = [TKAlertController TKAlertViewDialogShow:self.view Title:@"Title" text:@"Msg"];
            alert.blockDone = ^(id value) {
                UIAlertAction *action = (UIAlertAction *)value;
                NSLog(@"index:%ld  class:%@",action.tag,action);
            };
        }
            break;
        case 5:{
//                [TKMBProgressHUD showLoaddingInView:self.view after:2];
            AlertViewController *vc = [AlertViewController createVC];
            vc.restorationIdentifier = @"VC-B";
            vc.view.backgroundColor = UIColor.grayColor;
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
        case 6:{
//            [TKMBProgressHUD showText:@"titiel" inView:self.view];
            
            AlertViewController *vc = [AlertViewController createVC];
            vc.restorationIdentifier = @"VC-C";
            vc.view.backgroundColor = UIColor.grayColor;
            [self presentViewController:vc animated:YES completion:nil];
            
        }
            break;
        case 7:{
            self.picker1 = [TKSystemPhotoPicker showPhotoWithController:self isShear:NO];
//            self.picker1.isSaveAlbum = YES;
            self.picker1.allowsEditing = YES;
            self.picker1.blockImageDone = ^(id value) {
                NSLog(@"resultImage:%@",value);
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(150, 20, 100, 200)];
                    image.contentMode = UIViewContentModeScaleAspectFit;
                    image.image = value;
                    [weakSelf.view addSubview:image];
                });
            };
        }
            break;
        case 8:{
                self.picker1 = [TKSystemPhotoPicker showVideoWithController:self isShear:NO];
    //            self.picker1.isSaveAlbum = YES;
                self.picker1.allowsEditing = YES;
                self.picker1.blockVideoDone = ^(id value) {
                    NSLog(@"resultImage:%@",value);
                };        }
            break;
        case 9:{
            TKSimplePickerView *picker = [[TKSimplePickerView alloc] init];
            picker.defaultIndex = 4;
            picker.dataAry = @[@"1111",@"22222",@"33333",@"444444",@"555555"];
            picker.labTitle.text = @"Title";
//            picker.defaultIndex = 4;
            [picker show];
        }
            break;
        case 10:{
            TKDatePickerView *picker = [TKDatePickerView new];
//            picker.labTitle.text = @"Title";
            [picker show];
        }
            break;
        default:
            break;
    }
}


@end
