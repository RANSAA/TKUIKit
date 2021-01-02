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
    UIImage *image1 = [UIImage TKCreateSquareWithColor:UIColor.orangeColor size:CGSizeMake(15, 15) alpha:1.0];
    UIImage *image2 = [UIImage TKCreateSquareWithColor:UIColor.purpleColor size:CGSizeMake(15, 15) alpha:1.0];
    UIImage *image3 = [UIImage TKCreateCircularWithColor:UIColor.redColor size:CGSizeMake(27, 27) alpha:1.0];

    
    self.slider = [[TKSlider alloc] initWithFrame:CGRectMake(40, 248, 300, 60)];
    self.slider.delegate = self;
    self.slider.tag = 1;
    self.slider.backgroundColor = UIColor.grayColor;
    self.slider.minimumTrackTintColor = UIColor.redColor;
    self.slider.maximumTrackTintColor = UIColor.greenColor;
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 50;
    [self.view addSubview:self.slider];
    self.slider.centerThumb = YES;
    self.slider.isClick = YES;
    self.slider.showBufferView = YES;
    self.slider.bufferValue = 20;
    
//    self.slider.maximumValueImage = image2;
//      self.slider.minimumValueImage = image1;
    self.slider.bufferView.backgroundColor = UIColor.purpleColor;


    self.slider.thumbTintColor = UIColor.orangeColor;

//    image3 = [UIImage new];
//    [self.slider setThumbImage:image3 forState:UIControlStateNormal];
//    [self.slider setThumbImage:image3 forState:UIControlStateHighlighted];

  

    

//    UISlider *slider1 = [[UISlider alloc] initWithFrame:CGRectMake(40, 396, 300, 60)];
//    slider1.backgroundColor = UIColor.grayColor;
//    slider1.minimumTrackTintColor = UIColor.redColor;
//    slider1.maximumTrackTintColor = UIColor.greenColor;
//    slider1.thumbTintColor = UIColor.orangeColor;
//    [self.view addSubview:slider1];
//
//    slider1.thumbTintColor = UIColor.orangeColor;

//    [slider1 setThumbImage:image3 forState:UIControlStateNormal];
//    [slider1 setThumbImage:image3 forState:UIControlStateHighlighted];
    

    



    
    TKSlider *slider1 = [[TKSlider alloc] initWithFrame:CGRectMake(40, 396, 300, 60)];
    slider1.backgroundColor = UIColor.grayColor;
    slider1.minimumTrackTintColor = UIColor.redColor;
    slider1.maximumTrackTintColor = UIColor.greenColor;
    slider1.thumbTintColor = UIColor.orangeColor;
    [self.view addSubview:slider1];
//    slider1.minimumValueImage = image1;
//    slider1.maximumValueImage = image2;
    slider1.minimumValue = 0;
    slider1.maximumValue = 50;
    slider1.delegate = self;
    slider1.showBufferView = YES;
    slider1.bufferValue = 0.50;
    slider1.isClick = YES;





    
}

- (void)TKSlider:(TKSlider *)slider clickedValue:(CGFloat)value
{
    NSLog(@"clickedValue:%.2f",value);
}

- (void)TKSlider:(TKSlider *)slider changedValue:(CGFloat)value
{
    NSLog(@"changedValue:%.2f",value);
    self.slider.bufferValue = value+5;
}

- (void)TKSliderTouchBegan:(TKSlider *)slider
{
    NSLog(@"开始。。。。。");
}

- (void)TKSliderTouchEnd:(TKSlider *)slider
{
    NSLog(@"结束。。。。。。");
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
