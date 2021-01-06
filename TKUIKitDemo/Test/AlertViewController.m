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


@interface AlertViewController ()
@property(nonatomic, strong) TKSystemPhotoPicker *picker1;
@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI
{
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(44, 120, 84, 44);
    btn1.tag = 1;
    [btn1 setTitleText:@"alert1"];
    [btn1 addTarget:self action:@selector(btnAlertAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(244, 120, 84, 44);
    btn2.tag = 2;
    [btn2 setTitleText:@"alert2"];
    [btn2 addTarget:self action:@selector(btnAlertAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn3.frame = CGRectMake(44, 180, 84, 44);
    btn3.tag = 3;
    [btn3 setTitleText:@"alert sys"];
    [btn3 addTarget:self action:@selector(btnAlertAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn4.frame = CGRectMake(244, 180, 84, 44);
    btn4.tag = 4;
    [btn4 setTitleText:@"alert sys"];
    [btn4 addTarget:self action:@selector(btnAlertAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn5.frame = CGRectMake(44, 240, 84, 44);
    btn5.tag = 5;
    [btn5 setTitleText:@"alert MB"];
    [btn5 addTarget:self action:@selector(btnAlertAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn6.frame = CGRectMake(244, 240, 84, 44);
    btn6.tag = 6;
    [btn6 setTitleText:@"alert MB"];
    [btn6 addTarget:self action:@selector(btnAlertAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn6];
    
    UIButton *btn7 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn7.frame = CGRectMake(44, 300, 84, 44);
    btn7.tag = 7;
    [btn7 setTitleText:@"photo"];
    [btn7 addTarget:self action:@selector(btnAlertAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn7];
    
    UIButton *btn8 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn8.frame = CGRectMake(244, 300, 84, 44);
    btn8.tag = 8;
    [btn8 setTitleText:@"photo 2"];
    [btn8 addTarget:self action:@selector(btnAlertAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn8];
}

- (void)btnAlertAction:(UIButton *)btn
{
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
                    [self.view addSubview:image];
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
        default:
            break;
    }
}


@end
