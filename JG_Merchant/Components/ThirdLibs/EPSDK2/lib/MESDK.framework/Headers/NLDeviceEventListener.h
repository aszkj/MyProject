//
//  NLDeviceEventListener.h
//  mpos
//
//  Created by su on 13-6-18.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLDeviceEvent.h"
/*!
 @protocol
 @abstract 设备事件监听器
 @discussion
 在设备注册事件时,可以通过传入一个handler对象,这个对象将会在响应时通过接口返回,用于特定情况下的跨线程（如主线程）操作
 */
@protocol NLDeviceEventListener <NLDeviceEvent>
@optional
- (void)onEvent:(id <NLDeviceEvent>)event;
/**
 * 如果希望在事件响应时传入一个给定的线程，消息将推到相应线程进行处理,则期望该监听器返回不为空<p>
 *
 */
@optional
- (NSThread*)performHandler;
@end
