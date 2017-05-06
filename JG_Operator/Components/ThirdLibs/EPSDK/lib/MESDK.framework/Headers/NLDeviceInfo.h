//
//  NLDeviceInfo.h
//  mpos
//
//  Created by su on 13-6-18.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @enum
 @abstract 设备当前状态
 @constant NLDeviceStatePassivePrepared 无源待工
 @constant NLDeviceStatePassiveWorking 无源工作
 @constant NLDeviceStateActivePrepared 有源待工
 @constant NLDeviceStateActiveWorking 有源工作
 */
typedef enum {
    NLDeviceStatePassivePrepared = 0,
    NLDeviceStatePassiveWorking = 1,
    NLDeviceStateActivePrepared = 2,
    NLDeviceStateActiveWorking = 3,
} NLDeviceState;

/*!
 @enum
 @abstract 设备类型
 @constant NLDeviceTypeME30 ME30设备
 @constant NLDeviceTypeME31 ME31设备
 @constant NLDeviceTypeME11 ME11设备
 @constant NLDeviceTypeME81 ME81设备
 @constant NLDeviceTypeME30S ME30S设备
 @constant NLDeviceTypeME30C ME30C设备
 @constant NLDeviceTypeME31New ME31New设备
 @constant NLDeviceTypeUnKnown 未知设备 @since 1.0.6
 */
typedef enum {
    NLDeviceTypeME30,
    NLDeviceTypeME31,
    NLDeviceTypeME11,
    NLDeviceTypeME81,
    NLDeviceTypeME30S,
    NLDeviceTypeME30C,
    NLDeviceTypeME31New,
    NLDeviceTypeUnKnown
} NLDeviceType;

/*!
 @protocol DeviceInfo设备信息
 @abstract 设备信息
 @discussion 对于满足规范的设备，均必须遵循给定接口返回设备信息
 */
@protocol NLDeviceInfo <NSObject>
/*!
 @method 获得设备SN号
 @abstract
 @return SN
 */
- (NSString*)SN;
/*!
 @method 是否是工厂模式
 @abstract 如设备没有工厂化概念，则默认返回false
 @return true 当前设备是工厂模式 false 个人化完成
 */
- (BOOL)isFactoryModel;
/*!
 @method 获得当前安全设备固件版本
 @abstract
 @return 固件版本
 */
- (NSString*)firmwareVer;
/*!
 @method 获得设备的应用编号
 @abstract
 @return udid
 */
- (NSString*)udid;
/*!
 @method 获得设备应用版本号
 @abstract
 @return appVer
 */
- (NSString*)appVer;
/*!
 @method 获得客户定义的设备序列号CSN
 @abstract
 @return CSN
 */
- (NSString*)CSN;
/*!
 @method 获得客户定义的密钥序列号KSN
 @abstract
 @return KSN
 */
- (NSString*)KSN;
/*!
 @method 获得设备类型
 @abstract
 @return PID
 */
- (NLDeviceType)PID;
/*!
 @method 获得厂商VID
 @abstract
 @return VID
 */
- (NSString*)VID;
/*!
 @method 获得生产SN号(根据生产要求而自定义的SN号)
 @abstract
 @return customSN
 */
- (NSString*)customSN;
/**
 * 判断设备是否支持音频
 * @return
 */
- (BOOL)isSupportAudio;
/**
 * 判断设备是否支持蓝牙
 * @return
 */
- (BOOL)isSupportBlueTooth;
/**
 * 判断设备是否支持USB
 * @return
 */
- (BOOL)isSupportUSB;
/**
 * 判断设备是否支持磁条卡
 * @return
 */
- (BOOL)isSupportMagCard;
/**
 * 判断设备是否支持接触式IC卡
 * @return
 */
- (BOOL)isSupportICCard;
/**
 * 判断设备是否支持非接触IC卡
 * @return
 */
- (BOOL)isSupportQuickPass;
/**
 * 判断设备是否支持打印
 * @return
 */
- (BOOL)isSupportPrint;
/**
 * 判断设备是否支持屏幕显示
 * @return
 */
- (BOOL)isSupportLCD;
@end
