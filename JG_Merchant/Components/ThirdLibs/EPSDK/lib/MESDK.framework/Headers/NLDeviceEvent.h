//
//  NLDeviceEvent.h
//  mpos
//
//  Created by su on 13-6-18.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef long long int NLLong;
/*!
 @protocol
 @abstract 设备事件
 @discussion
 */
@protocol NLDeviceEvent <NSObject>
@optional
/*!
 @method
 @abstract 获得事件名称
 @return 事件名称
 */
- (NSString*)eventName;
/*!
 @method
 @abstract 获得发生该事件时的时间戳
 @return 时间戳
 */
- (NLLong)timestamp;
@end
