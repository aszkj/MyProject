//
//  NLAbstractDeviceConnection.h
//  MTypeSDK
//
//  Created by su on 13-6-24.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLDeviceConnection.h"
#import "NLCommandDescription.h"
#import "NLDeviceTouchController.h"
#import "NLCommandSerializer.h"

@interface NLAbstractDeviceConnection : NSObject<NLDeviceConnection>
@property (nonatomic, strong, readonly) NSString* connectionId;
- (id)initWithTouchController:(id<NLDeviceTouchController>)controller serializer:(id<NLCommandSerializer>)serializer connectId:(long)connId;
/**
 * 将指令序列化成一个字节流
 * @param deviceCmd 对应指令
 * @return
 * 		请求字节流
 */
- (NSData*)requestToPayload:(id<NLDeviceCommand>)deviceCmd;
/**
 * 将字节流反序列化成一个响应
 * @param deviceCmd 对应的指令类型
 * @param payload 响应实体
 * @return
 * 		响应实体
 */
- (id<NLDeviceResponse>)loadDeviceResponseWithCmd:(id<NLDeviceCommand>)deviceCmd payload:(NSData*)payload;
/**
 * 将字节流反序列化成一个响应
 * @param deviceCmd 对应的指令类型
 * @param payload 响应实体
 * @since 1.0.6
 * @return
 * 		响应实体
 */
- (id<NLDeviceResponse>)loadNotifiedDeviceResponseWithCmd:(id<NLDeviceCommand>)deviceCmd payload:(NSData*)payload;
/**
 * 获得一个指令的描述
 * @param deviceCmd 指令类型
 * @return
 * 		指令描述
 */
- (NLCommandDescription*)descriptionForDeviceCmd:(id<NLDeviceCommand>)deviceCmd;
@end
