//
//  NLBuzzer.h
//  MTypeSDK
//
//  Created by su on 14-3-19.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "NLModule.h"
/*!
 @protocol Buzzer 蜂鸣器通用模块
 @abstract 通用蜂鸣器模块
 @discussion
 */
@protocol NLBuzzer <NLModule>
/*!
 @method
 @abstract 调用一次蜂鸣操作
 @param times 蜂鸣次数 <p>
 @param frequence 频率 <p>
 @param pertime 每次蜂鸣时间 （单位：毫秒）<p>
 @param interval 间隔 （单位：毫秒）<p>
 */
- (void)callWithTimes:(int)times frequence:(int)frequence pertime:(int)pertime interval:(int)interval;
@end
