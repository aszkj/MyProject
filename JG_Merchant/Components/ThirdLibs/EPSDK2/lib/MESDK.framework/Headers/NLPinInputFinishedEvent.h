//
//  NLPinInputFinishedEvent.h
//  mpos
//
//  Created by su on 13-6-18.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLAbstractProcessDeviceEvent.h"

typedef enum {
    NLNotifyStepEnter,
    NLNotifyStepBackSpace
} NLNotifyStep;

/*!
 @class
 @abstract Pin输入事件<p>
 @discussion
 * 该事件支持密码输入时多次密码输入状态的返回<p>
 * 是否支持多次状态返回,取决于设备的实现。<p>
 * 例如：当接受到一个<tt>NLPinInputFinishedEvent</tt>，可以通过{@link #isProcessing()}来判断当前是否是一个未结束的状态。<p>
 * 参考以下实现<p>
 * <pre><blockquote>
 * 	if(pinInputEvent.isFailed){
 * 		@throw [pinInputEvent.error userInfo][NLErrorExceptionInfo];
 * 	}else if(pinInputEvent.isSuccess){
 * 		return pinInputEvent.encrypPin;
 * 	}else if(pinInputEvent.isProcessing){
 * 		{@link NLNotifyStep} step = pinInputEvent.notifyStep;
 * 		if(step == NLNotifyStepEnter){
 * 			//...可以给iOS上显示的输入pin增加一个'*'
 * 		}else{
 * 			//...可以给iOS上显示的输入pin减少一个'*'
 * 		}
 * 	}else if(pinInputEvent.isUserCanceled){
 * 		//处理用户撤消
 * 	}
 * </blockquote></pre>
 */
@interface NLPinInputFinishedEvent : NLAbstractProcessDeviceEvent
/*!
 @version 1.0.6
 @property notifyStep
 @abstract 若当前是一个键盘操作通知,则返回的通知类型.
 */
@property (nonatomic, assign, readonly) NLNotifyStep notifyStep;
@property (nonatomic, assign, readonly) int inputLen;
@property (nonatomic, strong, readonly) NSData* encrypPin;
@property (nonatomic, strong, readonly) NSData* ksn;
/**
 * 构造一个客户主动取消的密码键盘事件.
 */
- (id)init;
/**
 * 构造一个失败的密码键盘事件
 *
 * @param error
 */
- (id)initWithError:(NSError*)error;
/**
 * 构造一个成功的密码键盘事件
 * @param encryptPin
 */
- (id)initWithEncryptPin:(NSData*)encryptPin;
/**
 * 构造一个成功的密码键盘事件
 *
 * @param encryptPin
 */
- (id)initWithInputLen:(int)inputLen encryptPin:(NSData*)encryptPin ksn:(NSData*)ksn;
@end
