//
//  weather.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface weather : NSObject

@property (nonatomic, copy)NSString  *city;
@property (nonatomic, copy)NSString  *minWeather;
@property (nonatomic, copy)NSString  *maxWeather;
@property (nonatomic, copy)NSString  *weather;
@property (nonatomic, copy)NSString  *pm;//PM2.5
@property (nonatomic, copy)NSString  *sd_num;
@property (nonatomic, copy)NSString  *pm_lev;
@property (nonatomic, copy)NSString  *wind;//风向
@property (nonatomic, copy)NSString  *wind_lev;//风力
@property (nonatomic, copy)NSString  *st1;//背景图片编号

@property (nonatomic, copy)NSString  *pm_num;//星期几
@property (nonatomic, copy)NSString  *pm_pubtime;//时间

@end
