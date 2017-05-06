//
//  NLDeviceMenuEvent.h
//  MTypeSDK
//
//  Created by su on 15/7/8.
//  Copyright © 2015年 newland. All rights reserved.
//

#import "NLAbstractProcessDeviceEvent.h"
/*!
 @since 1.3.0
 @class
 @abstract 主动菜单唤醒事件
 @discussion 主要针对蓝牙带LCD序列设备
 */
@interface NLDeviceMenuEvent : NLAbstractProcessDeviceEvent
@property (nonatomic, assign, readonly) int keyCode;
@property (nonatomic, copy, readonly) NSString *eCode;
- (id)initWithkeyCode:(int)keyCode eCode:(NSString*)eCode;
@end
