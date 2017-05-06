//
//  QBleClient.h
//  WKLBle
//
//  Created by baoyx on 15/6/5.
//  Copyright (c) 2015年 baoyx. All rights reserved.
//

#define bleDiscoveredCharacteristicsNoti           @"ble-DiscoveredCharasNoti"
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, WKLBleErrorType) {
    WKLBleErrorTypeUnsupported = 0,  //不支持蓝牙错误
    WKLBleErrorTypePoweredOff,  //蓝牙未打开
    WKLBleErrorTypeScan, //搜索失败错误
    WKLBleErrorTypeNoPeripheral, //外设不存在错误
    WKLBleErrorTypeConnect,  //连接失败错误
    WKLBleErrorTypeDisConnect,  //断链错误
    WKLBleErrorTypeSend,      //发送指令超时错误
    WKLBleErrorTypeNotWrite,  //写通道不存在错误
    WKLBleErrorTypSyncMovementOut, //同步运动数据超时
    WKLBleErrorTypSyncSleepOut,   //同步睡眠数据超时
};

#pragma mark 蓝牙状态类型
typedef NS_ENUM(NSInteger,WKLBleState){
    WKLBleStateUnknown = 0, //初始化中状态
    WKLBleStateUnsupported , //不支持蓝牙状态
    WKLBleStatePoweredOff,  //未打开蓝牙状态
    WKLBleStatePoweredOn,  //蓝牙已启动状态
};


typedef NS_ENUM(NSInteger,RemindType)
{
    RemindTypeDrink = 0,  //喝水提醒
    RemindTypeSedentary,  //久坐提醒
    RemindTypeClock,      //闹钟提醒
    RemindTypeOnce,      //事件提醒(单次提醒)
};

typedef NS_ENUM(NSInteger,WarnEventType)
{
    WarnEventTypeOpen = 0, //打开
    WarnEventTypeClose,    //关闭
};
static NSString * SPOTA_SERVICE_UUID     = @"0000fef5-0000-1000-8000-00805f9b34fb";
static NSString * SPOTA_MEM_DEV_UUID     = @"8082caa8-41a6-4021-91c6-56f9b954cc34";
static NSString * SPOTA_GPIO_MAP_UUID    = @"724249f0-5ec3-4b5f-8804-42345af08651";
static NSString * SPOTA_MEM_INFO_UUID    = @"6c53db25-47a1-45fe-a022-7c92fb334fd4";
static NSString * SPOTA_PATCH_LEN_UUID   = @"9d84b9a3-000c-49d8-9183-855b673fda31";
static NSString * SPOTA_PATCH_DATA_UUID  = @"457871e8-d516-4ca1-9116-57d0b17b9cb2";
static NSString * SPOTA_SERV_STATUS_UUID = @"5f78df94-798c-46f5-990a-b3eb6a065c88";

typedef void (^CoreFailure)(NSError *error);
typedef void(^CoreSuccess)(id result);
@class CBCharacteristic;
@class CBPeripheral;
@class CBCentralManager;
@class CBService;
#pragma mark-------------纬科联蓝牙连接类
@protocol bleDidConnectionsDelegate<NSObject>

/**
 ****************************************************************************************
 * @brief       delegate ble update connected peripheral.
 *
 * @param[out]  aPeripheral : the connected peripheral.
 *
 ****************************************************************************************
 */
-(void)bleDidConnectPeripheral : (CBPeripheral *)aPeripheral;
@end
@protocol bleUpdateForOtaDelegate<NSObject>

/**
 ****************************************************************************************
 * @brief       delegate ble update service and chara.
 *
 * @param[out]  aPeripheral    : the peripheral connected.
 * @param[out]  aService       : the OTA service discovered.
 * @param[out]  error          : the error from CoreBluetooth if there is.
 *
 ****************************************************************************************
 */
-(void)bleDidUpdateCharForOtaService : (CBPeripheral *)aPeri
                         withService : (CBService *)aService
                               error : (NSError *)error;

/**
 ****************************************************************************************
 * @brief       delegate ble update value for Char.
 *
 * @param[out]  aService       : the OTA service discovered.
 * @param[out]  characteristic : the OTA characteristic updated.
 * @param[out]  error          : the error from CoreBluetooth if there is.
 *
 ****************************************************************************************
 */
-(void)bleDidUpdateValueForOtaChar : (CBService *)aService
                          withChar : (CBCharacteristic *)characteristic
                             error : (NSError *)error;
@end

@protocol bleScanDelegate<NSObject>

#pragma mark ------扫描外设代理
/**
 *  扫描外设代理
 *
 *  @param peripheral 外设对象数组(pe)
 */
-(void)scanPeripherals:(NSArray *)peripherals;

/**
 *  扫描外设代理
 *
 *  @param peripheral 扫描完成后,所有外设对象数组(pe)
 */
-(void)scanAllPeripherals:(NSArray *)peripherals;

@end

@protocol wklBleDidConnectionsDelegate<NSObject>

#pragma mark------连接外设成功代理
/**
 *  连接外设成功代理
 *
 *  @param aPeripheral 外设对象
 */
-(void)wklBleDidConnectPeripheral : (CBPeripheral *)aPeripheral;

#pragma mark------外设断开代理
/**
 *  外设断开代理
 *
 *  @param aPeripheral 外设对象
 */
-(void)wklBleDisConnectPeripheral : (CBPeripheral *)aPeripheral;
@end

@protocol  bleUpdateForDataDelegate<NSObject>

#pragma mark------数据写成功代理
/**
 *  数据写成功代理
 *
 *  @param characteristic 特征值
 *  @param error          错误信息
 */
-(void)bledidWriteValueForChar:(CBCharacteristic *)characteristic withError : (NSError *)error;

#pragma mark------接收数据成功代理
/**
 *  接收数据成功代理
 *
 *  @param characteristic 特征值
 *  @param error          错误信息
 */
-(void)bleDidUpdateValueForChar:(CBCharacteristic *)characteristic withError : (NSError *)error;
@end

@interface qBleClient : NSObject
@property (nonatomic,assign) id <bleUpdateForOtaDelegate>  bleUpdateForOtaDelegate;
@property (nonatomic,assign) id <bleDidConnectionsDelegate> bleDidConnectionsDelegate;
@property (nonatomic,weak) id<wklBleDidConnectionsDelegate>wklBleDidConnectionsDelegate;   //连接代理
@property (nonatomic,weak) id<bleUpdateForDataDelegate>bleUpdateForDataDelegate;   //蓝牙数据代理

@property (nonatomic,copy,readonly) CBPeripheral *activePeripheral;  //外设
@property (nonatomic,copy,readonly) CBCentralManager *centralManager; //中心设备
@property (nonatomic,assign,readonly) WKLBleState bleState;  //蓝牙状态
@property (nonatomic,weak) id<bleScanDelegate>bleScanDelegate;  //扫描外设代理
@property (nonatomic, readonly, retain) NSMutableArray *discoveredServices;

@property (nonatomic,copy,readonly) CBCharacteristic *spota_mem_dev_ch;
@property (nonatomic,copy,readonly) CBCharacteristic *spota_gpio_map_ch;
@property (nonatomic,copy,readonly) CBCharacteristic *spota_mem_info_ch;
@property (nonatomic,copy,readonly) CBCharacteristic *spota_patch_len_ch;
@property (nonatomic,copy,readonly) CBCharacteristic *spota_patch_data_ch;
@property (nonatomic,copy,readonly) CBCharacteristic *spota_serv_statasus_ch;



#pragma mark ---------纬科联蓝牙连接单例
/**
 *  纬科联蓝牙连接单例
 *
 *  @return 纬科联蓝牙连接单例对象
 */
+(qBleClient*)sharedInstance;

#pragma mark -----------开启中心设备(在AppDelegates设置)
/**
 *  开启中心设备(在AppDelegates设置)
 */
-(void)pubControlSetup;

#pragma mark ----------扫描外设
/**
 *  扫描外设
 *
 *  @param timeOut 扫描时长 当时长为
 *  @param error   扫描失败错误信息
 */
-(void)pubScanPeripherals:(NSInteger)timeOut withFailure:(CoreFailure)failure;

#pragma mark ----------停止外设扫描
/**
 *  停止外设扫描
 */
-(void)pubPeripheralStopScan;

#pragma mark ---------连接外设
/**
 *  连接外设
 *
 *  @param peripheral 外设对象
 *  @param timeOut    连接时长
 *  @param error      连接失败错误信息
 */
-(void)pubConnectPeripheral:(CBPeripheral *)peripheral withTimeout:(NSInteger)timeOut withFailure:(CoreFailure)failure;

#pragma mark -------写数据
/**
 *  写数据
 *
 *  @param data  数据信息
 *  @param error  写数据错误信息
 */
-(void)pubSendData:(NSData *)data withFailure:(CoreFailure)failure;

#pragma mark ----------断开连接
/**
 *  断开连接
 */
-(void)pubCancelPeripheral;

#pragma mark ---------开始OTA升级
/**
 *  开始OTA升级
 */
-(void)pubStartOTAUpgrade;

#pragma mark ---------停止OTA升级
/**
 *  停止OTA升级
 */
-(void)pubStopOTAUpgrade;

#pragma mark ---------清除外设对象
/**
 *  清除外设对象
 */
-(void)pubClearPeripheral;
@end

#pragma mark-------------纬科联蓝牙基础操作类
typedef NS_ENUM(NSInteger,GenderType) {
    GenderTypeWoman = 1,  //女
    GenderTypeMan,    //男
};

typedef NS_ENUM(NSInteger,UnitType) {
    UnitTypeMetric = 1 ,  //公制
    UnitTypeEnglish,  //英制
};

typedef NS_ENUM(NSInteger,LostType) {
    LostTypeOpen = 1,  //打开
    LostTypeClose ,  //关闭
};
@protocol  WKLBleBaseOperationMovementDataDelegate<NSObject>

#pragma mark ------接收运动数据
-(void)receviceMovementData:(NSData *)stepData;

@end

@protocol  WKLBleBaseOperationSleepDataDelegate<NSObject>

#pragma mark ------接收运动数据
-(void)receviceSleepData:(NSData *)stepData;

@end

@protocol  WKLBleBaseOperationPhotoMessageDelegate<NSObject>
#pragma mark ------接收设备照相
-(void)recevicePhotoMessage;

@end

@interface WKLBleBaseOperation : NSObject
@property (nonatomic,weak) id<WKLBleBaseOperationMovementDataDelegate>movementDataDelegate;
@property (nonatomic,weak) id<WKLBleBaseOperationSleepDataDelegate>sleepDataDelegate;
@property (nonatomic,weak) id<WKLBleBaseOperationPhotoMessageDelegate>photoMessageDelegate;

+(WKLBleBaseOperation *)sharedInstance;


#pragma mark -------------------- 同步参数(时间、身高、性别和体重等等)
/**
 *  同步参数(时间、身高、性别和体重等等)
 *
 *  @param step       目标步数
 *  @param genderType 性别
 *  @param age        年龄
 *  @param weight     体重   单位kg
 *  @param height     身高   单位cm
 *  @param unitType   单位类型(公制和英制)
 *  @param lostType   防丢
 *  @param isFirstSync  是不是第一次同步
 *  @param Success    同步成功(@{@"eqNumber"-->设备编号(NSString,格式如"00-12-56-45-48-45-78-41"),@"FirmwareVersion"--->固件版本(NSNumber),@"eqType"-->设备类型})
 *  @param failure    同步失败
 */
-(void)pubSyncWithGoalStep:(NSInteger)step withGenderType:(GenderType)genderType withAge:(NSInteger)age withWeight:(NSInteger)weight withHeight:(NSInteger)height withUnitType:(UnitType)unitType withLostType:(LostType)lostType isFirstSync:(BOOL)firstSync withSuccess:(CoreSuccess)success withFailure:(CoreFailure)failure;

#pragma mark -------------------- 同步运动数据
/**
 *  同步运动数据
 *
 *  @param startDay 开始时间（格式为yyyyMMdd)
 *  @param endDay   结束时间 (格式为yyyyMMdd)
 *  @param eqNumber 设备编号(NSString,格式如"00-12-56-45-48-45-78-41")
 *  @param Success 成功(@{@"totalToday"-->(NSNumber 总天数)})
 *  @param failure  失败
 备注:  startDay和endDay为 nil  同步所有运动数据
 */
-(void)pubSyncMovementWithStartDay:(NSString *)startDay withEndDay:(NSString *)endDay withEqNumber:(NSString *)eqNumber withSuccess:(CoreSuccess)success withFailure:(CoreFailure)failure;

#pragma mark -------------------- 同步睡眠数据
/**
 *  同步睡眠数据
 *
 *  @param startDay 开始时间（格式为yyyyMMdd)
 *  @param endDay   结束时间 (格式为yyyyMMdd)
 *  @param eqNumber 设备编号(NSString,格式如"00-12-56-45-48-45-78-41")
 *  @param Success 成功(@{@"totalToday"-->(NSNumber 总天数)})
 *  @param failure  失败
 备注:  startDay和endDay为 nil  同步所有睡眠数据
 */
-(void)pubSyncSleepWithStartDay:(NSString *)startDay withEndDay:(NSString *)endDay withEqNumber:(NSString *)eqNumber withSuccess:(CoreSuccess)success withFailure:(CoreFailure)failure;

#pragma mark --------------按键锁定(拍照)
/**
 *  按键锁定(拍照)
 *
 *  @param isLock  是否锁定
 *  @param time    锁定时间
 *  @param success 成功(@{@"error"-->"0":锁定成功或者解锁成功 "1":锁定失败或者解锁失败,@"message"-->消息体})
 *  @param failure 失败
 */
-(void)pubKeyLockWithLock:(BOOL)isLock withLockTime:(NSInteger)time withSuccess:(CoreSuccess)success withFailure:(CoreFailure)failure;

#pragma mark --------------防丢
/**
 * 防丢
 *
 *  @param isOpen   是否打开
 *  @param duration 持续时间（单位 ms）
 *  @param success  成功(@{@"error"-->"0":打开防丢成功或者关闭防丢成功 "1":防丢功能失效,@"message"-->消息体)
 *  @param failure  失败
 */
-(void)pubLostWithOpen:(BOOL)isOpen withLostDuration:(NSInteger)duration withSuccess:(CoreSuccess)success withFailure:(CoreFailure)failure;




#pragma mark   ---提醒设置(喝水、闹钟、单次(事件)
/**
 *  提醒设置(喝水、闹钟、单次(事件))
 *
 *  @param remindType 提醒类型
 *  @param eventType  事件类型(打开、关闭)
 *  @param hour       生效小时
 *  @param min        生效分钟
 *  @param success    提醒成功(@{@"error":"0"-->成功 "1"-->失败 @"message"--->消息体})
 *  @param failure    提醒失败
 */
-(void)pubStartWithRemindType:(RemindType)remindType withWarnEventType:(WarnEventType)eventType withHour:(int)hour withMin:(int)min withSuccess:(CoreSuccess)success withFailure:(CoreFailure)failure;

#pragma mark   ---久坐提醒设置
/**
 *  久坐提醒设置
 *
 *  @param eventType 事件类型(打开、关闭)
 *  @param duration  持续时间(分钟)
 *  @param startHour 开始小时
 *  @param startMin  开始分钟
 *  @param EndHour   结束小时
 *  @param EndMin    结束分钟
 *  @param success   久坐提醒设置成功
 *  @param failure   久坐提醒设置失败
 */

-(void)pubSedentaryWarnWithWarnEventType:(WarnEventType)eventType withDuration:(int)duration withStartHour:(int)startHour withStartMin:(int)startMin withEndHour:(int)EndHour withEndMin:(int)EndMin withSuccess:(CoreSuccess)success withFailure:(CoreFailure)failure;



#pragma mark -------------------- 设置空闲状态
/**
 *  设置空闲状态
 */
-(void)pubSetBleFunctionStateFree;

@end

#pragma mark-------------纬科联蓝牙计步类
@interface WKLBleStep : NSObject
+(WKLBleStep *)shareInstance;
/**
 *  同步运动数据
 *
 *  @param progress 同步进度
 *  @param startDay 开始时间（格式为yyyyMMdd)
 *  @param endDay   结束时间 (格式为yyyyMMdd)
 *  @param eqNumber 设备编号(NSString,格式如"00-12-56-45-48-45-78-41")
 *  @param success  成功 (@[@{@"sportStep"--->步数  @"sportTime"--->运动时间(yyyyMMddHHmm)}])
 *  @param failure  失败
 */
-(void)pubStartSyncMovementWithProgress:(void(^)(int progress))progress withStartDay:(NSString *)startDay withEndDay:(NSString *)endDay withEqNumber:(NSString *)eqNumber withSuccess:(CoreSuccess)success withFailure:(CoreFailure)failure;

@end

#pragma mark-------------纬科联蓝牙睡眠类
@interface WKLBleSleep : NSObject

+(WKLBleSleep *)shareInstance;
/**
 *  同步睡眠数据
 *
 *  @param progress 同步进度
 *  @param startDay 开始时间（格式为yyyyMMdd)
 *  @param endDay   结束时间 (格式为yyyyMMdd)
 *  @param eqNumber 设备编号(NSString,格式如"00-12-56-45-48-45-78-41")
 *  @param success  成功(@[@{@"dateTime"-->睡眠时间 @"startTime"-->开始时间(0~1440),@"sleepDuration"-->持续时间,@"sleepState"-->睡眠状态(0~5 0表示深睡  其他表示浅睡)}])
 *  @param failure  失败v
 */
-(void)pubStartSyncSleepWithProgress:(void(^)(int progress))progress withStartDay:(NSString *)startDay withEndDay:(NSString *)endDay withEqNumber:(NSString *)eqNumber withSuccess:(CoreSuccess)success withFailure:(CoreFailure)failure;

@end

