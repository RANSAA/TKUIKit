//
//  SilderViewController.m
//  TKUIKitDemo
//
//  Created by PC on 2020/12/31.
//  Copyright © 2020 芮淼一线. All rights reserved.
//

#import "SilderViewController.h"

@interface SilderViewController ()<TKSilderDelegate>
@property(strong , nonatomic) TKSlider *slider;
@end

@implementation SilderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)setupUI
{
    self.slider = [[TKSlider alloc] initWithFrame:CGRectMake(40, 248, 300, 60)];
    self.slider.delegate = self;
    self.slider.delegate = self;
//    self.slider.backgroundColor = UIColor.grayColor;
    self.slider.minimumTrackTintColor = UIColor.redColor;
    self.slider.maximumTrackTintColor = UIColor.greenColor;
    self.slider.thumbTintColor = UIColor.orangeColor;
    self.slider.minimumValue = 5;
    self.slider.maximumValue = 50;
    [self.view addSubview:self.slider];
    self.slider.isThumbCenter = YES;
    self.slider.isClick = YES;
    self.slider.showBufferView = YES;

    
    UIImage *image1 = [UIImage TKCreateSquareWithColor:UIColor.orangeColor size:CGSizeMake(15, 15) alpha:1.0];
    self.slider.minimumValueImage = image1;
    UIImage *image2 = [UIImage TKCreateSquareWithColor:UIColor.purpleColor size:CGSizeMake(15, 15) alpha:1.0];
    self.slider.maximumValueImage = image2;
    
    UIImage *image3 = [self TKCreateCircularWithColor:UIColor.redColor size:CGSizeMake(12, 12) alpha:1.0];
    [self.slider setThumbImage:image3 forState:UIControlStateNormal];
    [self.slider setThumbImage:image3 forState:UIControlStateHighlighted];
    NSLog(@"imageSize:%@    scale:%f",NSStringFromCGSize(image3.size),image3.scale);


    
    TKSlider *slider1 = [[TKSlider alloc] initWithFrame:CGRectMake(40, 396, 300, 30)];
    slider1.backgroundColor = UIColor.grayColor;
    slider1.minimumTrackTintColor = UIColor.redColor;
    slider1.maximumTrackTintColor = UIColor.greenColor;
    slider1.thumbTintColor = UIColor.orangeColor;
    [self.view addSubview:slider1];
//    slider1.minimumValueImage = image1;
//    slider1.maximumValueImage = image2;
//    slider1.isThumbCenter = YES;
    slider1.delegate = self;





    
}

- (void)TKSlider:(TKSlider *)slider clickedValue:(CGFloat)value
{
    NSLog(@"clickedValue:%.2f",value);
}

- (void)TKSlider:(TKSlider *)slider changedValue:(CGFloat)value
{
    NSLog(@"changedValue:%.2f",value);
//    value += 5;
    CGFloat s = (value-slider.minimumValue)/slider.maximumValue;
    slider.bufferValue = s+0.2;
}

- (void)TKSliderTouchBegan:(TKSlider *)slider
{
    NSLog(@"开始。。。。。");
}

- (void)TKSliderTouchEnd:(TKSlider *)slider
{
    NSLog(@"结束。。。。。。");
}


- (UIImage*)TKCreateCircularWithColor:(UIColor*)color size:(CGSize)size alpha:(CGFloat)alpha
{
    alpha = alpha>1?1:(alpha<0?0:alpha);
//    UIGraphicsBeginImageContext(size);
    //https://blog.csdn.net/larryluoshuai/article/details/78200434
    UIGraphicsBeginImageContextWithOptions(size,NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, alpha);
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillEllipseInRect(context, (CGRect){{0,0},size});

    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  resultImage;

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
