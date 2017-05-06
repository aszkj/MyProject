//
//  LongTimeSeatReminderModel.h
//  jingGang
//
//  Created by 张康健 on 15/6/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"

@interface LongTimeSeatReminderModel : NSObject

@property (nonatomic,copy)NSString *beginTime;
@property (nonatomic,copy)NSString *endTime;
@property (nonatomic,copy)NSString *duraTime;

@end
