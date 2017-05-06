//
//  NLDeviceKeyboardAwareEvent.h
//  MTypeSDK
//
//  Created by su on 13-10-23.
//  Copyright (c) 2013年 suzw. All rights reserved.
//
/*!
 @file
 @abstract
 @version 1.0.4
 */
#import "NLAbstractDeviceEvent.h"
/*!
 @class
 @asbtract 键盘唤醒事件
 @discussion
 */
@interface NLDeviceKeyboardAwareEvent : NLAbstractDeviceEvent
@property (nonatomic, readonly) int lastInput;
- (id)initWithEventName:(NSString *)eventName lastInput:(int)input;
@end
