//
//  CalenderView.h
//  jingGang
//
//  Created by 张康健 on 15/6/19.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+Utilities.h"

typedef void(^SelectBirthBlock)(NSString *year,NSString *month,NSString *day);
@class ClockPikcerView;

@interface CalenderView : UIView

@property (nonatomic) NSDate *MaxDate;
@property (nonatomic,copy)SelectBirthBlock selectBirthBlock;

//设置日期
-(void)setSelectedRowWithYearNum:(NSInteger)yearNum monthNum:(NSInteger )monthNum dayNum:(NSInteger)dayNum;
- (void)setCurrentDate:(NSDate *)date;


@end
