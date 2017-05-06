//
//  JGBlueToothManager.h
//  WKLBle
//
//  Created by 张康健 on 15/6/9.
//  Copyright (c) 2015年 baoyx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "QBleClient.h"
#import "UerBodyModel.h"
#import "UserBodySyncInfoModel.h"

typedef enum : NSUInteger {
    ConnectedState,  //已连接
    DiscnnectedState,//已断开
} BlooTuthState;//连接状态

typedef enum : NSUInteger {
    BecomeActiveState,//变得活跃状态
    ResignActiveState,//不活跃状态
} ActiveState;//活跃状态

typedef enum : NSUInteger {
    NeededSyncState,  //将要同步状态
    DontNeedSyncState,//不需要同步状态
}NeedToSyncState;//是否将要同步状态

typedef enum : NSUInteger {
    NeverConnectState,//从未连接过
    FirstConnectState,//第一次连接
    NotFirstConnectState,//不是第一次连接
} ConnectTimeState;


typedef void(^ScanPerialsResultBlock)(NSArray *perialsArr);//扫描结果

typedef void(^ScanPerialsAndConnectBandedPerialBlock)(BOOL connectSuccess);//扫描并且是否连接成功

typedef void(^ScanOrConnectErroBlock)(NSError *error);//连接错误

typedef void(^SyncProgressBlock)(int progress); //进度

typedef void(^SuccessBlock)(BOOL success);//成功

typedef void(^FailedBlock)(NSError *error);


@interface JGBlueToothManager : NSObject<bleScanDelegate,wklBleDidConnectionsDelegate>


+ (id)shareInstances;

#pragma mark - 开始扫描连接阶段
//开始扫描设备返回设备列表的
- (void)beginScanperipheralsWithResultPerials:(ScanPerialsResultBlock)scanResult falied:(ScanOrConnectErroBlock)falied;

//开始扫描设备并连接绑定设备
- (void)beginScanperipheralsAndConnectBandedPerialWithCennectResult:(ScanPerialsAndConnectBandedPerialBlock)connectSuccess falied:(ScanOrConnectErroBlock)failied;



#pragma mark ---------------服务----------------------------
//第一次点击连接，或者以后外部主动要求连接
//- (void)connectSpecifiedPerial:(CBPeripheral *)perial isFirstConnect:(BOOL)isfirstConect;
- (void)connectSpecifiedPerial:(CBPeripheral *)perial connectResult:(ScanPerialsAndConnectBandedPerialBlock)connectResult;

//同步参数,身高，体重，等等
-(void)syncParamater:(SuccessBlock)success;


//同步运动信息,主要是步数
-(void)syncMotionInfoForsyncResult:(ScanPerialsAndConnectBandedPerialBlock)syncMotionResult wihtSyncProgress:(SyncProgressBlock)progressBlock failed:(FailedBlock)failed;


//同步睡眠数据
-(void)syncSleepInfoForsyncResult:(ScanPerialsAndConnectBandedPerialBlock)syncSleepResult wihtSyncProgress:(SyncProgressBlock)progressBlock failed:(FailedBlock)failed;



//设置闹钟，
-(void)setArmClockAtHour:(int)hour
                  minute:(int)minute
            reminderType:(RemindType)reminderType
                warnType:(WarnEventType)warnType;


//久坐提醒
-(void)setLongSeatingRemindingFromBeginHour:(int)beginHour
                                beginMinute:(int)beginMinute
                                    endHour:(int)endHour
                                  endMinute:(int)endMinute
                                   duration:(int)durationMinutes
                               reminderType:(RemindType)reminderType
                               withWarnType:(WarnEventType)warnType;


//解除绑定
-(void)clearBanded;




#pragma mark ---------------属性----------------------------
//绑定的设备的UUID
@property (nonatomic,strong)NSString *bangedPerialUUID;


//绑定设备号
@property (nonatomic,strong)NSString *bangedPerialID;


//用户身体信息
@property (nonatomic,strong)UerBodyModel *userBodyModel;


//用户身体同步信息
@property (nonatomic,strong)UserBodySyncInfoModel *userBodySyncModel;


//是不是第一次连接
@property (nonatomic,assign)BOOL isFirstConnect;

//运动数据是否同步
@property (nonatomic,assign)BOOL isMotionSyned;

//睡眠数据是否同步
@property (nonatomic,assign)BOOL isSleepDataSyned;

//是否是刚刚解绑
@property (nonatomic,assign)BOOL isJustNowUnbangded;


//蓝牙连接状态
@property (nonatomic,assign)BlooTuthState connectState;


//活跃状态
@property (nonatomic,assign)ActiveState activeState;


//是否需要同步状态
@property (nonatomic,assign)NeedToSyncState needToSyncState;


//连接次数状态
@property (nonatomic,assign)ConnectTimeState connectTimeState;




@end
