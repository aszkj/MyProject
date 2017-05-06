//
//  NLAudioPortHelper.h
//  MTypeSDK
//
//  Created by su on 14/11/3.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @protocol NLAudioPortListener
 @abstract 音频口设备拔插监听器
 @discussion 音频口设备拔插检测回调
 */
@protocol NLAudioPortListener <NSObject>
@optional
/*!
 @method
 @abstract 当设备插入音频口时回调
 */
- (void)onDevicePlugged;
/*!
 @method
 @abstract 当设备从音频口拔出时回调
 */
- (void)onDeviceUnplugged;
@end

/*!
 @class NLAudioPortHelper 音频辅助类工具
 @abstract 音频口设备拔插辅助类
 @discussion
 */
@interface NLAudioPortHelper : NSObject
/*!
 @method
 @abstract 是否有音频设备插上
 @return 是否有设备插在音频口
 */
+ (BOOL)isDevicePresent;
/*!
 @method
 @abstract 注册音频口设备拔插监听器
 @param listener 音频口监听器
 */
+ (void)registerAudioPortListener:(id<NLAudioPortListener>)listener;
/*!
 @method
 @abstract 注销音频口设备拔插监听器
 */
+ (void)unregisterAudioPortListener;
@end
