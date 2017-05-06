//
//  LGDayModel.h
//  TestArrayCalendar
//
//  Created by AQ on 15-1-16.
//  Copyright (c) 2015年 AQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGDayModel : NSObject
@property (nonatomic,assign) NSInteger worldDay;
@property (nonatomic,assign) NSInteger chiDay;
@property (nonatomic,assign) NSInteger weekDay;
@property (nonatomic,strong) NSString *chiDayStr;
@property (nonatomic,strong) NSDate *dayDate;
@end
