//
//  NLKeyBoard.h
//  mpos
//
//  Created by su on 13-6-21.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLModule.h"
#import "NLDispType.h"
#import "NLKeyBoardReadingEvent.h"
/*!
 @protocol KeyBoard通用键盘模块
 @abstract 通用键盘模块
 @discussion
 */
@protocol NLKeyBoard <NLModule>
/*!
 @method
 @abstract 从键盘缓冲区立刻读取首个键值,若读取不到数据,则返回0x00<p>
 @return
 */
- (Byte)read;
/*!
 @method
 @abstract 在限定时间内,从键盘缓冲区读取键值,若读取不到数据,则返回0x00<p>
    该超时时间针对设备读取超时,即指令成功发送到设备后,设备开始判定读取超时.<p>
 @param readTimeout 限定超时时间
 @return
 */
- (Byte)readWithTimeout:(int)readTimeout;
/*!
 @method
 @abstract 开启一个标准金额读取流程<p>
 @param dispType 显示类型
 @param title 显示标题
 @param content 显示内容
 @param minLength 最小输入长度
 @param maxLength 最大输入长度
 @param timeout 超时时间
 @param listener 键盘输入监听器<NLKeyBoardReadingEvent<NSDecimalNumber>>
 * @return
 * 		读取的金额,若读取无返回,则返回为空。
 */
- (void)readAmtWithDispType:(NLDispType)dispType
                      title:(NSString*)title
                    content:(NSString*)content
                  minLength:(int)minLength
                  maxLength:(int)maxLength
                    timeout:(int)timeout
                   listener:(id<NLDeviceEventListener>)listener;
/*!
 @method
 @abstract 开启一个标准字符串读取流程。<p>
 @param dispType 显示类型
 @param title 显示标题
 @param content 显示内容
 @param minLength 最小输入长度
 @param maxLength 最大输入长度
 @param timeout 超时时间
 @param listener 键盘输入监听器<NLKeyBoardReadingEvent<NSString>>
 @return
 */
- (void)readStringWithDispType:(NLDispType)dispType
                         title:(NSString*)title
                       content:(NSString*)content
                     minLength:(int)minLength
                     maxLength:(int)maxLength
                       timeout:(int)timeout
                      listener:(id<NLDeviceEventListener>)listener;
/*!
 @method
 @abstract 开启一个标准数字读取流程。<p>
 @param dispType 显示类型
 @param title 显示标题
 @param content 显示内容
 @param minLength 最小输入长度
 @param maxLength 最大输入长度
 @param timeout 超时时间
 @param listener 键盘输入监听器<NLKeyBoardReadingEvent<NSDecimalNumber>>
 @return
 */
- (void)readNumberWithDispType:(NLDispType)dispType
                         title:(NSString*)title
                       content:(NSString*)content
                     minLength:(int)minLength
                     maxLength:(int)maxLength
                       timeout:(int)timeout
                      listener:(id<NLDeviceEventListener>)listener;
/*!
 @version 1.0.6
 @method
 @abstract 开启一个标准字密码读取流程<p>
            该方法将会控制设备界面按数字方式输入数据<p>
            该方法将异步执行，即时返回，设备响应将通过监听器返回处理结果。
 @param dispType 显示类型
 @param title 显示标题
 @param content 显示内容
 @param minLength 最小输入长度
 @param maxLength 最大输入长度
 @param timeout 超时时间
 @param listener 键盘输入监听器<NLKeyBoardReadingEvent<NSString>>
 @return
 */
- (void)readPwdWithDispType:(NLDispType)dispType
                         title:(NSString*)title
                       content:(NSString*)content
                     minLength:(int)minLength
                     maxLength:(int)maxLength
                       timeout:(int)timeout
                      listener:(id<NLDeviceEventListener>)listener;
/*!
 @version 1.0.4
 @method
 @abstract 撤消上次读取操作
 @discussion 仅撤消可撤消的{@link #readAmt},{@link #readStringWithDispType:title:content:minLength:maxLength:timeout:listener:},{@link #readNumberWithDispType:title:content:minLength:maxLength:timeout:listener:}方法。
 */
- (void)cancelLastReading;
@end
