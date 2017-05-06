//
//  NLDirectMessageListener.h
//  MTypeSDK
//
//  Created by wanglx on 14-7-24.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLDeviceResponse.h"
@protocol NLDirectMessageListener <NSObject>
@required
/**
 *  监听id
 *
 *  @return 监听id
 */
-(NSString *)ListenerId;
@required
/**
 *  返回该监听所监听的command
 *
 *  @return
 */
-(Class)ListenerCommandClass;
/**
 *  通知
 *
 *  @param resp
 */
-(void)notify:(id<NLDeviceResponse>)resp;
/**
 *  通知
 *
 *  @param cmd  返回的指令
 *  @param body 返回的指令包体
 */
-(void)notifyCmd:(NSData *)cmd body:(NSData *)body;
@end
