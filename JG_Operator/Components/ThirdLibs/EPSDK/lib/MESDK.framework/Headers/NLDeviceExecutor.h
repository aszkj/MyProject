//
//  NLDeviceExecutor.h
//  mpos
//
//  Created by su on 13-6-21.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLDeviceCommand.h"
#import "NLDeviceEventListener.h"
#import "NLDeviceResponse.h"
#import "NLDeviceConnectionState.h"
#import "NLInvokeEvent.h"
#import "NLDirectMessageListenerManager.h"
/**
 * 设备命令执行器<p>
 */
@protocol NLDeviceExecutor <NSObject>
/**
 * 非阻塞的方式,并使用默认指令超时时间({@link ExecutorConst#EXEC_TIMEOUT})执行一个设备指令。<p>
 *
 * @param deviceRequest 设备指令
 * @param listener 执行事件监听器
 */
- (void)invoke:(NSObject<NLDeviceCommand>*)deviceRequest listener:(NLInvokeEvent<NLDeviceEventListener>*)listener;
/**
 * 非阻塞的方式，使用指定超时时间执行一个设备指令。<p>
 *
 * @param deviceRequest 设备指令
 * @param timeout 超时时间
 * @param timeunit 超时时间量级
 * @param listener 执行事件监听器
 */
- (NSObject<NLDeviceResponse>*)invoke:(NSObject<NLDeviceCommand>*)deviceRequest timeout:(int)timeout listener:(NLInvokeEvent<NLDeviceEventListener>*)listener;
/**
 * 阻塞的方式，使用指定超时时间去执行一个设备指令。<p>
 *
 * @param deviceRequest 设备指令
 * @param timeout 超时时间
 * @param timeunit 超时时间量级
 *
 * @return
 * 		响应结果
 */
- (NSObject<NLDeviceResponse>*)invoke:(NSObject<NLDeviceCommand>*)deviceRequest timeout:(int)timeout;
/**
 * 阻塞的方式，使用默认指令超时时间({@link ExecutorConst#EXEC_TIMEOUT})执行一个设备指令。<p>
 *
 * @param deviceRequest 设备指令
 *
 * @return
 * 		响应结果
 */
- (NSObject<NLDeviceResponse>*)invoke:(NSObject<NLDeviceCommand>*)deviceRequest;
/**
 * 撤消所有当前正在执行的指令<p>
 *
 */
- (void)cancelCurrentExecCmd;
/**
 * 关闭连接器
 */
- (void)destroy;
/**
 * 判定该连接器是否存活。
 *
 * @return
 */
- (BOOL)isAlive;
/**
 * 用于判定连接是否处于繁忙状态
 *
 * @return
 */
- (BOOL)isBusy;
/**
 * 获得该连接的状态<p>
 *
 * @return
 */
- (NLDeviceConnectionState)deviceConnectionState;

-(id<NLDirectMessageListenerManager>)directMessageListenerManager;

@end
