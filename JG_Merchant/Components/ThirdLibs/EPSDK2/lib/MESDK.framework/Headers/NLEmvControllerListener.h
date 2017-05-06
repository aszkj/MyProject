//
//  NLEmvControllerListener.h
//  MTypeSDK
//
//  Created by su on 14-1-27.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLEmvTransController.h"
/*!
 @protocol
 @abstract Emv流程控制监听器
 @discussion
 */
@protocol NLEmvControllerListener <NSObject>
/**
 * 当设备要求app响应一个应用选择时发生.<p>
 * 若设备自己完成选择或者强制应用选择,该事件不触发<p>
 *
 * @param controller emv交易控制器
 * @param data 设备响应数据
 * @throws err
 */
- (void)onRequestSelectApplication:(id<NLEmvTransController>)controller context:(NLEmvTransInfo*)context error:(NSError*)err;

/**
 * 当设备要求app响应一个客户交易信息确认时发生。<p>
 * 若在设备上完成交易信息确认，则该事件不触发。<p>
 *
 * @param controller emv交易控制器
 * @param data 设备响应数据
 */
- (void)onRequestTransferConfirm:(id<NLEmvTransController>)controller context:(NLEmvTransInfo*)context error:(NSError*)err;

/**
 * 当设备要求app完成一个密码输入过程时发生<p>
 * 若在设备上完成密码输入，则该事件不触发<p>
 * 需要使用联机<tt>PIN</tt>或脱机<tt>PIN</tt>，将根据返回参数中的 @TODO 声明<p>
 *
 * @param controller emv交易控制器
 * @param data设备响应数据
 * @throws err
 */
- (void)onRequestPinEntry:(id<NLEmvTransController>)controller context:(NLEmvTransInfo*)context error:(NSError*)err;

/**
 * 当设备要求联机交易时发生<p>
 *
 * @param controller emv交易控制器
 * @param data 操作数据
 */
- (void)onRequestOnline:(id<NLEmvTransController>)controller context:(NLEmvTransInfo*)context error:(NSError*)err;


/**
 * 当emv交易正常结束时发生。<p>
 * 正常结束包括交易失败,或者是emv交易被拒绝等状态，应该要注意同{@link #onError(EmvTransController, Exception)}的区别。<p>
 * {@link #onError(EmvTransController, Exception)} 表示一个异常结束，而这个异常很可能使得这个交易没有正确处理完成。<p>
 * 而该事件则表示设备一定正常完成交易处理。不需要再执行{@link EmvTransController#cancelEmv()}等操作.但如果发生了二次授权,有可能需要发起一个冲正<p>
 *
 * @param data 交易处理结果，可能是TC或者AAC
 */
- (void)onEmvFinished:(BOOL)isSuccess context:(NLEmvTransInfo*)context error:(NSError*)err;

/**
 * 当emv流程要求一个fallback交易的时候进行处理
 *
 * @param context
 * @throws err
 */
- (void)onFallback:(NLEmvTransInfo*)context error:(NSError*)err;

/**
 * 当有任何错误时发生<p>
 *
 * @param controller emv交易控制器
 * @param e
 */
- (void)onError:(id<NLEmvTransController>)controller error:(NSError*)err;
//- (void)onError:(NLEmvTransController controller,Exception e);
@end
