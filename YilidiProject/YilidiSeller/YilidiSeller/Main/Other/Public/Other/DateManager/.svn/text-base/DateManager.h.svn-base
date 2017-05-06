//
//  DateManager.h
//  YilidiSeller
//
//  Created by yld on 16/7/7.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  时间管理者，为什么时间类要单独作为一个管理者，，因为时间类很耗性能，尤其是NSDateFormatter如果反复初始化的话，会极其耗费性能，所以搞个单例只让他初始化一次
 */

@interface DateManager : NSObject

+ (instancetype)sharedManager;

/**
 *  获取给定时间后的一个小时，时间都是字符串
 */
- (NSString *)afterAnHourTimeWithTheBasicTime:(NSString *)basicTime;

@end
