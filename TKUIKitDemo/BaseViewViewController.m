//
//  BaseViewViewController.m
//  TKUIKitDemo
//
//  Created by PC on 2020/12/31.
//  Copyright © 2020 芮淼一线. All rights reserved.
//

#import "BaseViewViewController.h"

@interface BaseViewViewController ()

@end

@implementation BaseViewViewController

+ (instancetype)createVCFromStory
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    id obj = [story instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"%@",self.class]];
    UIViewController *vc = (UIViewController *)obj;
    vc.modalPresentationStyle = 0;
    return obj;
}

+ (instancetype)createVC
{
    Class class = self.class;
    id obj = [[class alloc] init];
    UIViewController *vc = (UIViewController *)obj;
    vc.modalPresentationStyle = 0;
    return obj;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"ClassName:%@",self.class);
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupUI];
    
    [self addBack];
}

- (void)setupUI
{
    
}

- (void)addBack
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnBackAction) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 20, 64, 44);
    [self.view addSubview:btn];
}

- (void)btnBackAction
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"dealloc vc name:%@",self.class);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
