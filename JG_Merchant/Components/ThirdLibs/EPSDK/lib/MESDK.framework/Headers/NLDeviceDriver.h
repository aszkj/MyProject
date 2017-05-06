//
//  NLDeviceDriver.h
//  mpos
//
//  Created by su on 13-6-20.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLDeviceConnParams.h"
#import "NLDeviceConnType.h"
#import "NLDevice.h"
#import "NLDeviceEventListener.h"
#import "NLConnectionCloseEvent.h"
#import "NLDeviceKeyboardAwareEvent.h"
/*!
 @protocol DeviceDriver设备驱动入口
 @abstract 设备驱动入口
 @discussion
 一个加载的例子:<p>
 <pre><blockquote>
 Class&lt;DeviceDriver&gt; m31DriverClass = Class.forName("com.newland.m31.M31Driver");
 M31Driver diver = (M31Driver)m31DriverClass.newInstance();
 
 TODO
 */
@protocol NLDeviceDriver <NSObject>
/*!
 @method
 @abstract 获得驱动的主版本号
 @return
 */
- (int)majorVersion;
/*!
 @method
 @abstract 获得驱动的子版本号
 @return
 */
- (int)minorVersion;
/*!
 @method
 @abstract 获得支持的连接类型
 @return
 */
- (NSArray*)supportConnType;
/*!
 @method 
 @abstract 判断是否支持某种连接方式
 @param connType 被测试的连接方式
 @return
 */
- (BOOL)isSupportedConnType:(NLDeviceConnType)connType;
/*!
 @method 
 @abstract 通过一个连接参数连接设备,若连接失败则抛出异常
 @discussion 连接过程可以注册一个事件监听器,用于在连接成功后,被关闭时响应关闭事件。
 @see ConnectionCloseEvent
 @param connParams 连接参数
 @param closedListener 关闭事件(得到的事件是一个NLConnectionCloseEvent事件)
 @throws Exception
 @return
 */
- (id<NLDevice>)connectWithConnParams:(id<NLDeviceConnParams>)connParams closedListener:(id<NLDeviceEventListener>)closedListener error:(NSError**)err;
/*!
 @version 1.0.4
 @method
 @abstract 通过一个连接参数连接设备,若连接失败则抛出异常
 @discussion 连接过程可以注册一个事件监听器,用于在连接成功后,被关闭时响应关闭事件。<p>
            连接过程可以注册一个键盘唤醒事件监听器，若设备本身支持键盘唤醒，则该监听器将用于事件处理。<p>
 @see ConnectionCloseEvent
 @param connParams 连接参数
 @param closedListener 关闭事件(得到的事件是一个NLConnectionCloseEvent事件)
 @param awareListener 键盘唤醒事件(得到的事件是一个NLConnectionCloseEvent事件)
 @throws Exception
 @return
 */
- (id<NLDevice>)connectWithConnParams:(id<NLDeviceConnParams>)connParams
                       closedListener:(id<NLDeviceEventListener>)closedListener
                        awareListener:(id<NLDeviceEventListener>)awareListener
                                error:(NSError**)err;
/*!
 @version 1.0.6
 @method
 @abstract 通过一个连接参数连接设备,若连接失败则抛出异常
 @discussion 连接过程可以注册一个事件监听器,用于在连接成功后,被关闭时响应关闭事件。<p>
 连接过程可以注册一个键盘唤醒事件监听器，若设备本身支持键盘唤醒，则该监听器将用于事件处理。<p>
 @see ConnectionCloseEvent
 @param connParams 连接参数
 @param closedListener 关闭事件(得到的事件是一个NLConnectionCloseEvent事件)
 @param launchListener 设备启动或唤醒事件(得到的事件是一个NLDeviceLaunchEvent事件)
 @throws Exception
 @return
 */
- (id<NLDevice>)connectWithConnParams:(id<NLDeviceConnParams>)connParams
                       closedListener:(id<NLDeviceEventListener>)closedListener
                       launchListener:(id<NLDeviceEventListener>)launchListener
                                error:(NSError **)err;
@end
