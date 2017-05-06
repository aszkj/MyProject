//
//  CalenderHeaderCell.m
//  jingGang
//
//  Created by 张康健 on 15/7/31.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "CalenderHeaderCell.h"
#import "NSDate+Utilities.h"
#import "NSDate+Addition.h"
#import "GlobeObject.h"
@interface CalenderHeaderCell(){

    NSString  *_timeTitle;
}

@end

@implementation CalenderHeaderCell

- (void)awakeFromNib {
    //时间button初始化
    _currentDate = [NSDate date];
    self.timeLabel.text = [self getYearDayMonthStr];
    [self bringSubviewToFront:self.timeButton];
}


-(NSString *)getYearDayMonthStr{

    NSInteger year = [self.currentDate year];
    NSInteger month = [self.currentDate month];
    NSInteger day = [self.currentDate day];
//    NSLog(@"%@",[NSString stringWithFormat:@"%ld年%02ld月%02ld日",year,month,day]);
    return [NSString stringWithFormat:@"%ld年%02ld月%02ld日",year,month,day];
}


- (IBAction)preDayAction:(id)sender {
    
    //减一天
    self.currentDate = [self.currentDate dateBySubtractingDays:1];

}//上一天

- (IBAction)displayTimeCalenderAction:(id)sender {

    //弹出日历通知
    [kNotification postNotificationName:@"pelletCallender" object:nil];
   
}//

- (IBAction)nextDayAction:(id)sender {
    //加一天
    self.currentDate = [self.currentDate dateByAddingDays:1];

}//下一天

- (void)setCurrentDateWithYMD:(NSString *)dateString {

}

-(void)setCurrentDate:(NSDate *)currentDate {
    _currentDate = currentDate;
    self.timeLabel.text = [self getYearDayMonthStr];
    //之后每次改变都会发送一个改变时间的通知
    [kNotification postNotificationName:@"timeChangedNotification" object:[_currentDate dateWithFormat:@"yyyy-MM-dd"]];
    
}

@end
