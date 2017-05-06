//
//  NLBluetoothHelper.h
//  MTypeSDK
//
//  Created by su on 13-6-29.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @enum NLBluetoothState
 @abstract 蓝牙4.0状态
 @constant NLBluetoothStateUnsupported 设备不支持蓝牙4.0（iphone4s以下、iOS5以下）
 @constant NLBluetoothStateOpened 蓝牙已打开
 @constant NLBluetoothStateClosed 蓝牙已关闭
 */
typedef enum {
    NLBluetoothStateUnsupported,
    NLBluetoothStateOpened,
    NLBluetoothStateClosed
} NLBluetoothState;

/*!
 @class BluetoothHelper蓝牙辅助工具类
 @abstract 蓝牙辅助工具类
 @discussion 提供扫描发现设备，获取设备列表（name-uuid键值对字典），当前是否连接蓝牙设备。
 */
@interface NLBluetoothHelper : NSObject
/*!
 @method
 @abstract 是否已连接上蓝牙设备
 @discussion
 */
+ (BOOL)isConnected;
/*!
 @method
 @abstract 可供连接的蓝牙设备对象（备选）
 @discussion
 @return 可供连接的蓝牙设备列表（name-uuid键值对字典）
 */
+ (NSDictionary*)devices;
/*!
 @method
 @abstract 开始扫描
 @discussion
 */
+ (void)startScan;
/*!
 @method
 @abstract 在给定时间(秒为单位)周期内扫描设备
 @discussion
 @param duration 同步扫描周期（秒为单位）
 @return 可供连接的蓝牙设备列表（name-uuid键值对字典）
 */
+ (NSDictionary*)syncScanWithDuration:(int)duration;
/*!
 @method
 @abstract 停止扫描
 @discussion
 */
+ (void)stopScan;
/*!
 @method
 @abstract 清除所有已入栈的设备列表
 @discussion
 */
+ (void)clearAllDevices;
/*!
 @method
 @abstract 判断蓝牙是否能访问(是否打开或支持蓝牙4.0)
 @discussion
 @return 蓝牙4.0模块状态
 */
+ (NLBluetoothState)bluetoothState;
@end
