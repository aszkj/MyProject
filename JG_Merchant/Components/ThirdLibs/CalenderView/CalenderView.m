//
//  CalenderView.m
//  jingGang
//
//  Created by 张康健 on 15/6/19.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "CalenderView.h"
#import "ClockPikcerView.h"

@implementation CalenderView


-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.clipsToBounds = YES;
    NSMutableArray *yearsArr = [NSMutableArray arrayWithCapacity:0];
    for (int i=1915; i<=2050; i++ ) {
        NSNumber *num = @(i);
        [yearsArr addObject:[num stringValue]];
    }
    self.yearPikerView.data = yearsArr;
    self.yearPikerView.selectedTimeStr = yearsArr[0];
    
    NSMutableArray *monthsArr = [NSMutableArray arrayWithCapacity:0];
    for (int i=1; i<=12; i++ ) {
        NSNumber *num = @(i);
        [monthsArr addObject:[num stringValue]];
    }
    self.monthPikerView.data = monthsArr;
    self.monthPikerView.selectedTimeStr = monthsArr[0];
    
    NSMutableArray *daysArr = [NSMutableArray arrayWithCapacity:0];
    for (int i=1; i<=31; i++ ) {
        NSNumber *num = @(i);
        [daysArr addObject:[num stringValue]];
    }
    self.dayPikerViiew.data = daysArr;
    self.dayPikerViiew.selectedTimeStr = daysArr[0];
    
    [self.yearPikerView reloadAllComponents];
    [self.monthPikerView reloadAllComponents];
    [self.dayPikerViiew reloadAllComponents];
    
    _overlayView = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _overlayView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setSelectedRowWithYearNum:(NSInteger)yearNum monthNum:(NSInteger )monthNum dayNum:(NSInteger)dayNum {
    if (yearNum > 2050|| yearNum < 1915) {
        return;
    }
    self.yearPikerView.selectedTimeStr = [NSString stringWithFormat:@"%ld",yearNum];
    NSInteger seletedYearRow = yearNum - 1915;
    [self.yearPikerView selectRow:seletedYearRow inComponent:0 animated:YES];
    
    if (monthNum < 1 || monthNum > 12) {
        return;
    }
    self.monthPikerView.selectedTimeStr = [NSString stringWithFormat:@"%ld",monthNum];
    
    NSInteger seletedMonthRow = monthNum - 1;
    [self.monthPikerView selectRow:seletedMonthRow inComponent:0 animated:YES];
    
    if (dayNum < 1 || dayNum > 365) {
        return;
    }
    self.dayPikerViiew.selectedTimeStr = [NSString stringWithFormat:@"%ld",dayNum];
    
    NSInteger seletedDayRow = dayNum - 1;
    [self.dayPikerViiew selectRow:seletedDayRow inComponent:0 animated:YES];
    
    [self.yearPikerView reloadAllComponents];
    [self.monthPikerView reloadAllComponents];
    [self.dayPikerViiew reloadAllComponents];
}

- (IBAction)makeSureAction:(id)sender {
    
    if (self.selectBirthBlock) {
        if ([self.monthPikerView.selectedTimeStr integerValue] < 10) {
            self.monthPikerView.selectedTimeStr = [NSString stringWithFormat:@"0%@",self.monthPikerView.selectedTimeStr];
        }
        if ([self.dayPikerViiew.selectedTimeStr integerValue] < 10) {
            self.dayPikerViiew.selectedTimeStr = [NSString stringWithFormat:@"0%@",self.dayPikerViiew.selectedTimeStr];
        }
        
        self.selectBirthBlock(self.yearPikerView.selectedTimeStr,self.monthPikerView.selectedTimeStr,self.dayPikerViiew.selectedTimeStr);
    }
    [self dismiss];
}

- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}
- (void)fadeOut
{
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [_overlayView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

- (void)show
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:_overlayView];
    [keywindow addSubview:self];
    
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                              keywindow.bounds.size.height - self.bounds.size.height/2);
    [self fadeIn];
}

- (void)dismiss
{
    [self fadeOut];
}

- (void)dealloc {
    
}
@end
