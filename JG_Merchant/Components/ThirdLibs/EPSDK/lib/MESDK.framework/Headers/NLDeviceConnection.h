//
//  NLDeviceConnection.h
//  MTypeSDK
//
//  Created by su on 13-6-24.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLDeviceResponse.h"
#import "NLDeviceCommand.h"
#import "NLDirectMessageListenerManager.h"
@protocol NLInvokeStateNotifyListener <NSObject>
- (void)notify:(id<NLDeviceResponse>)deviceResponse;
@end
/*!
 @protocol
 @abstract 描述一个设备连接
 @discussion 连接不可以多次开关使用，对于连接的生命周期，可以认为从类对象创建开始，到调用close的过程。
     如果判定isClosing == true,则应该被所有持有对象丢弃。
 */
@protocol NLDeviceConnection <NLDirectMessageListenerManager>
/*!
 @method 获得连接标示
 @abstract 该连接标示应该在容器里唯一
 @return
 */
- (NSString*)connectionId;
/*!
 @method 发送一个交易请求
 @abstract 该方法在响应前一定确保阻塞
 @discussion 
    对于一般性出错，该方法都不应该期待抛出异常。若交易处理异常,则通过<tt>DeviceResponse</tt>里对<tt>isSuccess</tt>声明返回.<p>
    若该方法抛出异常，将认为该连接无法再次使用。将会连接管理器被调用<tt>close()</tt>回收
 @return
 */
- (id<NLDeviceResponse>)send:(id<NLDeviceCommand>)request error:(NSError**)err;

- (id<NLDeviceResponse>)send:(id<NLDeviceCommand>)request eventListener:(id<NLInvokeStateNotifyListener>)eventListener error:(NSError **)err;
/*!
 @version 1.0.6
 @method 发送一个交易请求
 @abstract 该方法在响应前一定确保阻塞，附响应超时时间
 @discussion
 对于一般性出错，该方法都不应该期待抛出异常。若交易处理异常,则通过<tt>DeviceResponse</tt>里对<tt>isSuccess</tt>声明返回.<p>
 若该方法抛出异常，将认为该连接无法再次使用。将会连接管理器被调用<tt>close()</tt>回收
 @return
 */
- (id<NLDeviceResponse>)send:(id<NLDeviceCommand>)request timeout:(NSTimeInterval)timeout error:(NSError**)err;
- (id<NLDeviceResponse>)send:(id<NLDeviceCommand>)request timeout:(NSTimeInterval)timeout eventListener:(id<NLInvokeStateNotifyListener>)eventListener error:(NSError**)err;
/*!
 @method
 @abstract 是否执行了心跳
 @return
 */
- (BOOL)isTouch;
/*!
 @method
 @abstract 判断连接是否关闭
 @return
 */
- (BOOL)isClosed;
/*!
 @method
 @abstract 判断关闭连接
 @return
 */
- (void)close:(NSError**)err;
/**
 * 撤销所有的报文请求
 * @abstract private
 */
- (void)cancelAllRequest;
@end


