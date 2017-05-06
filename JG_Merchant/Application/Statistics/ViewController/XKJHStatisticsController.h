//
//  XKJHStatisticsController.h
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHBaseController.h"

typedef enum : NSUInteger {
    StatisticsOnLine = 1, //线上刷卡统计
    StatisticsOffLine = 2, //线下刷卡统计
    StatisticsConsume = 3, //消费返润统计
} StatisticsType; //分润统计

@interface XKJHStatisticsController : XKJHBaseController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, assign)StatisticsType statisticsType;

@end
