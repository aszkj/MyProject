//
//  NLEventHolder.h
//  MTypeSDK
//
//  Created by szq on 14-3-4.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NLDeviceEventListener.h"
#import "NLDeviceEvent.h"
/*!
 @class
 @abstract 事件线程阻塞控制监听器
 @discussion
 */
@interface NLEventHolder : NSObject<NLDeviceEventListener>
@property (nonatomic, strong, readonly) id<NLDeviceEvent> event;
@property (nonatomic, readonly) BOOL isClosed;
- (void)startWait:(NSError**)err;
@end
