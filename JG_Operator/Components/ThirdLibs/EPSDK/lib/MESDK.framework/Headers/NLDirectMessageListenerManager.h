//
//  NLDirectMessageListenerManager.h
//  MTypeSDK
//
//  Created by wanglx on 14-7-24.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLDirectMessageListener.h"
@protocol NLDirectMessageListenerManager <NSObject>
/**
 * 注册一个直接消息监听器
 *
 * @param listener
 */
-(void)registerDirectMessageListener:(id<NLDirectMessageListener>)listener;

/**
 * 移除一个直接消息监听器
 * @param listener
 */
-(void)removeDirectMessageListener:(id<NLDirectMessageListener>)listener;

/**
 * 移除所有的直接消息监听器
 */
-(void)removeAllListeners;
@end
