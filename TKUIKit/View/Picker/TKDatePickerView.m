//
//  TKDatePickerView.m
//  Orchid
//
//  Created by Mac on 2019/2/23.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TKDatePickerView.h"

@interface TKDatePickerView ()


@end

@implementation TKDatePickerView

- (void)instanceSubView
{
    self.labTitle.text = nil;
    self.labTitle.font = [UIFont systemFontOfSize:16];
    
    UIColor *titleColor  = [UIColor TKLightColor:UIColor.blackColor darkColor:kRGBColor(188, 188, 192)];
    UIColor *backColor   = [UIColor TKLightColor:kRGBColor(68, 68, 70) darkColor:kRGBColor(188, 188, 192)];
    UIColor *toolColor = [UIColor TKLightColor:kRGBColor(245, 245, 245) darkColor:kRGBColor(58, 58, 60)];
    UIColor *pickerColor   = [UIColor TKLightColor:UIColor.whiteColor darkColor:kRGBColor(72, 72, 74)];
    self.datePicker.backgroundColor = pickerColor;
    self.toolView.backgroundColor = toolColor;
    self.labTitle.textColor = titleColor;
    [self.btnDone setTitleColor:backColor];
    [self.btnCancel setTitleColor:backColor];
}

- (void)show
{
    [self showWithView:appWin];
}

- (void)showWithView:(UIView *)view
{
    self.frame = Screen_Bounds;
    [view addSubview:self];
    [view.layer addAnimation:[TKAnimation TKAnimationGetFade] forKey:nil];
}

- (void)hiddenView
{
    [self.superview.layer addAnimation:[TKAnimation TKAnimationGetFade] forKey:nil];
    [self removeFromSuperview];
}

- (IBAction)btnCancelAction:(UIButton *)sender {
    [sender setViewUserInteractionEnabledCancel];
    [self hiddenView];
}

- (IBAction)btnDoneAction:(UIButton *)sender {
    [sender setViewUserInteractionEnabledCancel];
    [self hiddenView];
    
    NSDate *date = self.datePicker.date;
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormat stringFromDate:date];
    if([self.delegate respondsToSelector:@selector(TKDatePickerViewWith:date:dateStr:)]){
        [self.delegate TKDatePickerViewWith:self date:date dateStr:dateStr];
    }
    if (self.blockDate) {
        self.blockDate(date);
    }
    if (self.blockDateStr) {
        self.blockDateStr(dateStr);
    }
}

@end
