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
    NSLog(@"SilderViewController viewDidLoad");
  
}

- (void)dealloc
{
    NSLog(@"SilderViewController");
}

- (void)setupUI
{
    UIImage *image1 = [UIImage TKCreateSquareWithColor:UIColor.orangeColor size:CGSizeMake(15*2, 15*2) alpha:1.0];
    UIImage *image2 = [UIImage TKCreateSquareWithColor:UIColor.purpleColor size:CGSizeMake(15, 15) alpha:1.0];
    UIImage *image3 = [UIImage TKCreateCircularWithColor:UIColor.redColor size:CGSizeMake(27, 27) alpha:1.0];

    //system
    UISlider *sysSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 60, 300, 60)];
//    sysSlider.backgroundColor = UIColor.grayColor;
    [self.view addSubview:sysSlider];



    self.slider = [[TKSlider alloc] initWithFrame:CGRectMake(20, 130, 300, 60)];
    self.slider.tag = 1;
    self.slider.delegate = self;
    self.slider.backgroundColor = UIColor.grayColor;
    self.slider.minimumTrackTintColor = UIColor.redColor;
    self.slider.maximumTrackTintColor = UIColor.greenColor;
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 50;
    [self.view addSubview:self.slider];
//    self.slider.centerThumb = YES;
    self.slider.isClick = YES;
    self.slider.bufferValue = 0.2;
    self.slider.bufferView.backgroundColor = UIColor.purpleColor;


    TKSlider *slider0 = [[TKSlider alloc] initWithFrame:CGRectMake(20, 210, 300, 60)];
    slider0.delegate = self;
    slider0.backgroundColor = UIColor.grayColor;
    slider0.minimumTrackTintColor = UIColor.redColor;
    slider0.maximumTrackTintColor = UIColor.greenColor;
    slider0.minimumValue = 0;
    slider0.maximumValue = 50;
    [self.view addSubview:slider0];
    slider0.isClick = YES;
    slider0.bufferValue = 0.2;
    slider0.maximumValueImage = image1;
    slider0.minimumValueImage = image3;
    slider0.bufferView.backgroundColor = UIColor.purpleColor;
    


    TKSlider *slider1 = [[TKSlider alloc] initWithFrame:CGRectMake(20, 280, 300, 60)];
    slider1.tag = 2;
    slider1.backgroundColor = UIColor.grayColor;
    slider1.minimumTrackTintColor = UIColor.redColor;
    slider1.maximumTrackTintColor = UIColor.greenColor;
    slider1.thumbTintColor = UIColor.orangeColor;
    [self.view addSubview:slider1];
//    slider1.minimumValueImage = image1;
//    slider1.maximumValueImage = image2;
//    slider1.thumbImage = image1;
//    slider1.thumbImage = [TKSlider imageWithSize:CGSizeMake(27, 27) color:UIColor.cyanColor];
    slider1.minimumValue = 0;
    slider1.maximumValue = 50;
    slider1.delegate = self;
//    slider1.showBufferView = YES;
    slider1.bufferValue = 0.50;
    slider1.isClick = YES;
    slider1.centerThumb = YES;




    TKIndicatorView *indicatior0 = [[TKIndicatorView alloc] initWithFrame:CGRectMake(20, 50, 100, 100) style:TKIndicatorViewDefaultStyle];
    indicatior0.lineColor = UIColor.purpleColor;
    [self.view addSubview:indicatior0];


    TKIndicatorView *indicatior1 = [[TKIndicatorView alloc] initWithFrame:CGRectMake(20, 150, 100, 100) style:TKIndicatorViewLinearStyle];
    indicatior1.lineColor = UIColor.purpleColor;
    [self.view addSubview:indicatior1];

    TKIndicatorView *indicatior2 = [[TKIndicatorView alloc] initWithFrame:CGRectMake(20, 250, 100, 100) style:TKIndicatorViewLinearSegmentStyle];
    indicatior2.lineColor = UIColor.purpleColor;
    [self.view addSubview:indicatior2];

    TKIndicatorView *indicatior3 = [[TKIndicatorView alloc] initWithFrame:CGRectMake(20, 350, 100, 100) style:TKIndicatorViewGradientStyle];
    indicatior3.lineColor = UIColor.purpleColor;
    indicatior3.patternColor = @[UIColor.redColor,UIColor.orangeColor,UIColor.yellowColor,UIColor.cyanColor];
    [self.view addSubview:indicatior3];

    TKIndicatorView *indicatior4 = [[TKIndicatorView alloc] initWithFrame:CGRectMake(20, 450, 100, 100)];
    indicatior4.lineColor = UIColor.cyanColor;
    [self.view addSubview:indicatior4];
    
}


- (void)TKSlider:(TKSlider *)slider changedValue:(CGFloat)value
{
    NSLog(@"changedValue:%.2f",value);
    self.slider.bufferValue = value/(slider.maximumValue-slider.minimumValue)+0.05;
}

- (void)TKSlider:(TKSlider *)slider endValue:(CGFloat)value
{
    NSLog(@"endValue:%.2f",value);
}




@end
