//
//  CalenderView.h
//  jingGang
//
//  Created by 张康健 on 15/6/19.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectBirthBlock)(NSString *year,NSString *month,NSString *day);
@class ClockPikcerView;
@interface CalenderView : UIView
{
    UIControl *_overlayView;
}

@property (retain, nonatomic) IBOutlet ClockPikcerView *yearPikerView;
@property (retain, nonatomic) IBOutlet ClockPikcerView *monthPikerView;
@property (retain, nonatomic) IBOutlet ClockPikcerView *dayPikerViiew;

@property (nonatomic,copy)SelectBirthBlock selectBirthBlock;

//设置picker选中行
-(void)setSelectedRowWithYearNum:(NSInteger)yearNum monthNum:(NSInteger )monthNum dayNum:(NSInteger)dayNum;
- (void)show;
- (void)dismiss;

@end
