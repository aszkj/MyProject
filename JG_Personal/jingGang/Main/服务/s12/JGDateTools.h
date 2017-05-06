//
//  JGDateTools.h
//  jingGang
//
//  Created by dengxf on 15/12/22.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGDateTools : NSObject


@property (strong,nonatomic) NSMutableArray *containArray;

+(instancetype)sharedInstanced;

/**
 *  是否在指定的时间段内
 *  @param beginTime 开始时间
 *  @param endTime   结束时间
 */
- (BOOL)nowContainedActivityPeriodWithBeginTime:(NSString *)beginTime endTime:(NSString *)endTime;

/**
 *  查今天信息
 *
 */
+ (NSString *)nowDateInfo;

/**
 *  添加时间
 */
+ (void)addDate:(NSString *)dateString;

/**
 *  查询数组
 *
 */
+ (NSMutableArray *)queryArray;


/**
 *  查询
 *
 */
+ (BOOL)checkShouldPopDateSting:(NSString *)dateString;



- (NSDate *)handleResposTimeForm:(NSString *)formTime ;



@end
