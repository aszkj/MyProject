//
//  NLDeviceTouchController.h
//  MTypeSDK
//
//  Created by su on 13-6-24.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NLDeviceConnection.h>
/*!
 @protocol
 @abstract touch方式实现接口
 @discussion
 */
@protocol NLDeviceTouchController <NSObject>
/*!
 @method
 @abstract 发起一次心跳测试
 @param deviceConnection 给定的连接
 @return 是否真实发起心跳。
 */
- (BOOL)isTouch:(id<NLDeviceConnection>)deviceConnection;
@end
