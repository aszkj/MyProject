//
//  NLDeviceLaunchEvent.h
//  MTypeSDK
//
//  Created by su on 14/10/14.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "NLAbstractProcessDeviceEvent.h"
/*!
 @constant 设备启动/唤醒数据项
 */
extern NSString *const NLDeviceLaunchDataInfo;
/*!
 @class
 @abstract 设备启动唤醒事件
 @discussion 主要针对音频序列设备
 */
@interface NLDeviceLaunchEvent : NLAbstractProcessDeviceEvent
- (id)initWithEventName:(NSString *)eventName error:(NSError *)error;
- (id)initWithEventName:(NSString *)eventName userInfo:(NSDictionary*)userInfo;
- (NSDictionary*)userInfo;
@end
