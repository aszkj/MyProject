//
//  NLConnectionCloseEvent.h
//  MTypeSDK
//
//  Created by su on 13-6-26.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLAbstractProcessDeviceEvent.h"
/*!
 @class
 @abstract 连接关闭
 @discussion 
 */
@interface NLConnectionCloseEvent : NLAbstractProcessDeviceEvent
- (id)initWithEventName:(NSString *)eventName;
- (id)initWithEventName:(NSString *)eventName error:(NSError *)error;
@end
