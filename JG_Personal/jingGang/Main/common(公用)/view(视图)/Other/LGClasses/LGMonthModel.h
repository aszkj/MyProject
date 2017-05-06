//
//  LGMonthModel.h
//  TestArrayCalendar
//
//  Created by AQ on 15-1-16.
//  Copyright (c) 2015年 AQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGMonthModel : NSObject
@property (strong,nonatomic) NSArray *daysArray;
@property (assign,nonatomic) NSInteger daysCount;
@property (assign,nonatomic) NSInteger worldMoth;
@property (assign,nonatomic) NSInteger chiMonth;
@property (assign,nonatomic) NSInteger worldYear;
@property (assign,nonatomic) NSInteger chiYear;
@end
