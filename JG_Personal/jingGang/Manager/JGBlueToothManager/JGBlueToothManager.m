//
//  JGBlueToothManager.m
//  WKLBle
//
//  Created by 张康健 on 15/6/9.
//  Copyright (c) 2015年 baoyx. All rights reserved.
//

#import "JGBlueToothManager.h"
#import "WKLBleFirmware.h"
#import "LKDBHelper.h"
#import "DrinkWaterMoel.h"
#import "GetAwakeModel.h"
#import "LongTimeSeatReminderModel.h"
//绑定的设备的key
#define BANDED_PERIAL_UIID_KEY  @"banded_perial_uuid_key"

//绑定设备的号码key
#define BANDED_PERIAL_ID_KEY  @"banded_perial_id_key"

//绑定设备key
//#define BANDED_PERIAL_KEY @"banded_perial_key"

#define UserDefault  [NSUserDefaults standardUserDefaults]

#define UserDefaultSetObjectOfKey(object,key)  [[NSUserDefaults standardUserDefaults] setObject:object forKey:key]

#define UserDefaltGetObjectForKye(key)      [[NSUserDefaults standardUserDefaults] valueForKey:key]


//默认连接请求超时时间
#define KDefaultConnectTimeOut  5


static JGBlueToothManager *_JGBlueManager = nil;

@interface JGBlueToothManager(){

    BOOL _isConnected;
    
    CBPeripheral *_connectedPerialBefore; //之前连接过的设备
    
    LKDBHelper *_lkDBHelper;

}

@property (nonatomic,strong)NSArray *scanResultPerialArr;
@property (nonatomic,copy)ScanPerialsResultBlock scanPerialsResultBlock;
@property (nonatomic,copy)ScanPerialsAndConnectBandedPerialBlock scanPerialsAndConnectBandedPerialBlock;
@property (nonatomic,copy)ScanOrConnectErroBlock scanOrConnectErroBlock;

@property (nonatomic,copy)FailedBlock failedBlock;

//连接请求超时时间
@property int connectTimeOut;
//每次扫描计数
@property int scanTimesCount;



@property (nonatomic,assign)BOOL isFirstSync;//是不是第一次同步参数

@property (nonatomic,assign)BOOL isArmClockSet;

@property (nonatomic,assign)BOOL isOpenBlueTooth;//蓝牙是否开启



@end

@implementation JGBlueToothManager


+ (id)shareInstances
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _JGBlueManager = [[JGBlueToothManager alloc]init];
    });
    

    return _JGBlueManager;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        [self _initInfo];
    }
    return self;
}



#pragma mark - private Method
-(void)_initInfo{
    
    //初始化用户身体信息
    id m = [[UerBodyModel alloc] init];
    self.userBodyModel = m;
    RELEASE(m);
    
    //初始化用户身体同步信息
    m = [[UserBodySyncInfoModel alloc] init];
    self.userBodySyncModel = m;
    RELEASE(m);
    
    
    //初始化绑定设备信息
    NSString *bangedPerialUUID = UserDefaltGetObjectForKye(BANDED_PERIAL_UIID_KEY);
    
    NSLog(@"bangedPerialUUID:%@",bangedPerialUUID);
    
    if (bangedPerialUUID != nil) {
        self.bangedPerialUUID = bangedPerialUUID;
    }
    
    NSString *bangedPerialID = UserDefaltGetObjectForKye(BANDED_PERIAL_ID_KEY);
    
    NSLog(@"bangedPerialID:%@",bangedPerialID);

//    self.isFirstSync = YES;
    if (bangedPerialID != nil) {
        self.bangedPerialID = bangedPerialID;
        //不是第一次同步参数
//        self.isFirstSync = NO;
        //说明不是第一次连接
        self.connectTimeState = NotFirstConnectState;
    }else{//说明还没绑定,从没连接过
        self.connectTimeState = NeverConnectState;
        
    }
    
    //获取绑定设备
//    _connectedPerialBefore = UserDefaltGetObjectForKye(BANDED_PERIAL_KEY);
    
    
    //开始不活跃状态
    self.activeState = ResignActiveState;
    
    //初始化不需要同步
    self.needToSyncState = NeededSyncState;
    
    //初始化没连接
    self.connectState = DiscnnectedState;
    
    //初始化闹钟信息，设置闹钟
//    [self _intArmLockInfo];
    self.isArmClockSet = NO;
    
    //蓝牙默认为开启标志
    self.isOpenBlueTooth = YES;
    
    
    //初始化请求超时时间
    self.connectTimeOut = 0;
    
    self.isJustNowUnbangded = NO;
    

}//初始化


-(BOOL)_lookForBandedPerialAtPerialArr:(NSArray *)perialArr{
    
    
    BOOL find = NO;
    for (NSDictionary *perialDic in perialArr) {
        CBPeripheral *perial =perialDic[@"peripheral"];
        if ([perial.identifier.UUIDString isEqualToString:self.bangedPerialUUID]) {
            find = YES;
            break;
        }
    }
    
    return NO;
}//寻找设备列表中的绑定设备



-(void)_connectPerialWithBandedID:(NSString *)bandedID atPerialsArr:(NSArray *)perialsArr{

    for (NSDictionary *perialDic in perialsArr) {
        CBPeripheral *perial =perialDic[@"peripheral"];
        if ([perial.identifier.UUIDString isEqualToString:bandedID]) {
            [self _conectPerial:perial];
            break;
        }
    }
    
}//连接搜索设备列表中的绑定设备

-(void)_conectPerial:(CBPeripheral *)perial{
    NSInteger connectTimeOut = self.connectTimeOut ? self.connectTimeOut : KDefaultConnectTimeOut;
    
    if (perial) {
#if TARGET_IPHONE_SIMULATOR
        
#else
        [[qBleClient sharedInstance] pubConnectPeripheral:perial withTimeout:KDefaultConnectTimeOut withFailure:^(NSError *error) {
            NSLog(@"errorConnect=%@",[error description]);
            [self _cancelConnectPerial];
        }];
#endif

    }
}

-(void)_cancelConnectPerial{
#if TARGET_IPHONE_SIMULATOR
    
#else
    [[qBleClient sharedInstance] pubCancelPeripheral];

#endif
    
}//断开连接


-(void)_scanPerial{
#if TARGET_IPHONE_SIMULATOR
    
#else
qBleClient *qlent = [qBleClient sharedInstance];
    //扫描代理
    qlent.bleScanDelegate = self;

    //连接代理
    qlent.wklBleDidConnectionsDelegate = self;
    _scanTimesCount += 1;
    [qlent pubScanPeripherals:5 withFailure:^(NSError *error) {
       
        NSLog(@"errorScan=%@",[error description]);
        self.isOpenBlueTooth = NO;
        NSError *error2;
        if (self.failedBlock && error.code == 1) {//蓝牙未打开
            error2 = [NSError errorWithDomain:@"蓝牙未打开，请打开蓝牙" code:1 userInfo:nil];
            
        }else{//蓝牙打开了，未扫描到
        
            error2 = [NSError errorWithDomain:@"扫描失败，请确保身边有蓝牙设备" code:1 userInfo:nil];
        
        }
        if (self.failedBlock) {
            
            self.failedBlock(error2);
            //错误传过去之后，重置蓝牙标志，
            self.isOpenBlueTooth = YES;
        }
    }];

#endif
        

}//扫描设备，并设置代理



-(void)_setBandedPerialBeforeWithScanedPerials:(NSArray *)perialsArr{

    for (NSDictionary *perialDic in perialsArr) {
        CBPeripheral *perial =perialDic[@"peripheral"];
        if ([perial.identifier.UUIDString isEqualToString:self.bangedPerialUUID]) {
            _connectedPerialBefore = perial;
            break;
        }
    }
    
}//设备绑定之后，，以后每次扫描设备，，找到绑定设备，给绑定设备赋值



#pragma mark - 开始扫描设备
- (void)beginScanperipheralsWithResultPerials:(ScanPerialsResultBlock)scanResult falied:(ScanOrConnectErroBlock)falied
{
    
    NSLog(@"sadklsajdlsas");
    self.scanPerialsResultBlock = scanResult;
    self.failedBlock = falied;

//    //如果断开连接就扫描
//    if (self.connectState == DiscnnectedState) {
        _scanTimesCount = 1;
        [self _scanPerial];
//    }else{//若已经连接了,再连接
//        [self _conectPerial:_connectedPerialBefore];
//        
//    }
    
}//开始扫描设备返回设备列表的



- (void)beginScanperipheralsAndConnectBandedPerialWithCennectResult:(ScanPerialsAndConnectBandedPerialBlock)connectSuccess falied:(ScanOrConnectErroBlock)failied
{
    
    self.scanPerialsAndConnectBandedPerialBlock = connectSuccess;
    self.scanOrConnectErroBlock = failied;

//    //如果断开连接就扫描
//    if (self.connectState == DiscnnectedState) {
//    
//        [self _scanPerial];
//    }else{//若已经连接了,再连接
//        if (_connectedPerialBefore) {
//            
//            [self _conectPerial:_connectedPerialBefore];
//        }
//        
//    }
    _scanTimesCount = 1;
    [self _cancelConnectPerial];
    
    [self performSelector:@selector(_scanPerial) withObject:nil afterDelay:0.2];

}//开始扫描设备并连接绑定设备


#pragma mark - 扫描结果代理
-(void)scanPeripherals:(NSArray *)peripherals
{

    self.scanResultPerialArr = peripherals;
    NSLog(@"perial:%ld",peripherals.count);
    
    //判断有没绑定设备，根据绑定设备UUID记录
    if (self.bangedPerialUUID) {//绑定了，
        //寻找扫描结果中的绑定设备
            //直接连接该设备
            [self _connectPerialWithBandedID:self.bangedPerialUUID atPerialsArr:peripherals];

    }else{//没有绑定，，显示扫描设备列表，，把设备列表丢给显示控制器
        if (peripherals.count > 0) {
            
        }else{
        
        }
    }
    //从扫描的设备列表中，给绑定设备赋值，，为了防止，即使扫描到了绑定设备，但是没连接上，_connectedPerialBefore没有赋值
    if (peripherals.count > 0) {
        [self _setBandedPerialBeforeWithScanedPerials:peripherals];
    }
}


-(void)scanAllPeripherals:(NSArray *)peripherals
{
    NSLog(@"总共perias:%ld",peripherals.count);
    //如果蓝牙打开了，没有扫描到设备,并且没有绑定
    if (self.isOpenBlueTooth && peripherals.count == 0&&!self.bangedPerialUUID) {
        NSError *error = [NSError errorWithDomain:@"未扫描到外设，请确保身边有可用蓝牙设备" code:2 userInfo:nil];
        if (self.failedBlock) {
//            if (_scanTimesCount == 5) {
                _scanTimesCount = 1;
                self.failedBlock(error);
            return;
//            }
        }
    }else{
        if (self.scanPerialsResultBlock) {
            self.scanPerialsResultBlock(peripherals);
        }
    }
    
    //如果蓝牙打开了，并且绑定设备了，，但是没有扫描到，
    if (self.isOpenBlueTooth && self.bangedPerialUUID && peripherals.count == 0) {
        NSString *alertStr = @"正在扫描设备..";
        NSInteger errocode = 3;
        if (_scanTimesCount == 5) {
            alertStr = @"扫描设备失败";
            errocode = 4;
        }
         NSError *error = [NSError errorWithDomain:alertStr code:errocode userInfo:nil];
        if (self.scanOrConnectErroBlock) {
            self.scanOrConnectErroBlock(error);
        }
        if (_scanTimesCount == 5) {
            return;
        }
    }
    
    //如果蓝牙关了，，并且绑定了,
    if (!self.isOpenBlueTooth &&  peripherals.count == 0) {
        
        NSError *error = [NSError errorWithDomain:@"蓝牙已关闭，请开启蓝牙" code:1 userInfo:nil];
        if (self.scanOrConnectErroBlock) {
            //重置蓝牙标志
            self.isOpenBlueTooth = YES;
//            if (_scanTimesCount < 2) {
                _scanTimesCount = 1;
                self.scanOrConnectErroBlock(error);
                return;
//            }
        }
    }
    //从扫描的设备列表中，给绑定设备赋值，，为了防止，即使扫描到了绑定设备，但是没连接上，_connectedPerialBefore没有赋值
    if (peripherals.count > 0) {
        if (!self.bangedPerialUUID) {
            [self _setBandedPerialBeforeWithScanedPerials:peripherals];
        }else {
            [self _connectPerialWithBandedID:self.bangedPerialUUID atPerialsArr:peripherals];
        }
    }else {//重新扫描
        if (_scanTimesCount > 5) {
            return;
        }
        [self performSelector:@selector(_scanPerial) withObject:nil afterDelay:0.3];
    }
    

}


#pragma mark - 连接结果代理
-(void)wklBleDidConnectPeripheral : (CBPeripheral *)aPeripheral
{
    NSLog(@"已连接设备UUID:%@",aPeripheral.identifier.UUIDString);

    self.scanPerialsAndConnectBandedPerialBlock(YES);

    _isConnected = YES;
    
    if (!self.bangedPerialUUID) {//从未绑定过
        //第一次存起来
        UserDefaultSetObjectOfKey(aPeripheral.identifier.UUIDString, BANDED_PERIAL_UIID_KEY);
        [UserDefault synchronize];
        
        self.bangedPerialUUID = aPeripheral.identifier.UUIDString;
        
        //第一次绑定，赋值绑定设备,并将其缓存
//        _connectedPerialBefore = aPeripheral;
        
//        UserDefaultSetObjectOfKey(aPeripheral, BANDED_PERIAL_KEY);
    }
    self.connectState = ConnectedState;
    //把连接的设备记录下来
    _connectedPerialBefore = aPeripheral ;
    
//    if (self.isFirstConnect) {//若是第一次连接，置位
//        self.isFirstConnect = NO;
//    }
    
    if (!self.isArmClockSet) {//如果闹钟没初始化
     
        [self _intArmLockInfo];
        self.isArmClockSet = YES;
    }
    
}


-(void)wklBleDisConnectPeripheral:(CBPeripheral *)aPeripheral{
//    NSLog(@"断开连接");
//    _isConnected = NO;
//    self.connectState = DiscnnectedState;
//    if (self.activeState == BecomeActiveState) {//如果当前是活跃状态断开了，那么就重连
//        if (_connectedPerialBefore) {
//            NSLog(@"重新连接");
////            sleep(1);
//            [self _conectPerial:_connectedPerialBefore];
//        }
//    }
//
    
    [self _scanPerial];
    
}


#pragma mark --------------------------------外部服务-------------------------------------------

#pragma mark - 外部请求主动连接某设备
- (void)connectSpecifiedPerial:(CBPeripheral *)perial connectResult:(ScanPerialsAndConnectBandedPerialBlock)connectResult
{
    self.scanPerialsAndConnectBandedPerialBlock = connectResult;
    
    [self _conectPerial:perial];
}


//同步参数,身高，体重，等等
-(void)syncParamater:(SuccessBlock)success{
    
#if TARGET_IPHONE_SIMULATOR
    
#else
    //    BOOL firstSync = self.bangedPerialID ? 0 : 1;
WKLBleBaseOperation *operation = [WKLBleBaseOperation sharedInstance];
    [operation pubSyncWithGoalStep:self.userBodyModel.goalSteps withGenderType:self.userBodyModel.genderType withAge:self.userBodyModel.age withWeight:self.userBodyModel.weight withHeight:self.userBodyModel.height withUnitType:UnitTypeMetric withLostType:LostTypeClose isFirstSync:self.isFirstSync withSuccess:^(NSDictionary *result) {
        
        NSLog(@"sync result=%@",result);
//        if (self.isFirstSync) {//第一次同步
            self.bangedPerialID = result[@"eqNumber"];
            UserDefaultSetObjectOfKey(self.bangedPerialID, BANDED_PERIAL_ID_KEY);
            [UserDefault synchronize];
//        }
        success(YES);
        
        
//        eqNumber_ = result[@"eqNumber"];
    } withFailure:^(NSError *error) {
        NSLog(@"sync params error =%@",[error description]);
    }];

#endif
        
}


-(void)syncMotionInfoForsyncResult:(ScanPerialsAndConnectBandedPerialBlock)syncMotionResult wihtSyncProgress:(SyncProgressBlock)progressBlock failed:(FailedBlock)failed{
    self.scanPerialsAndConnectBandedPerialBlock = syncMotionResult;
    
    self.failedBlock = failed;
    
    //同步之前先连接
    if (_connectedPerialBefore ) {
        
        self.connectTimeOut = 3;
        if (_connectedPerialBefore) {
            
            [self _conectPerial:_connectedPerialBefore];
        }
    }
 
#if TARGET_IPHONE_SIMULATOR
    
#else
[[WKLBleStep shareInstance] pubStartSyncMovementWithProgress:^(int progress) {
        
        NSLog(@"progress=%ld",(long)progress);
        progressBlock(progress);
        
    } withStartDay:nil withEndDay:nil withEqNumber:self.bangedPerialID withSuccess:^(id result) {
        NSLog(@"%@",result);
        for (NSDictionary *step in result) {
            NSLog(@"步数:%@ 运动时间:%@",step[@"sportStep"],step[@"sportTime"]);
        }
        
        //先把基本模型给它，计算需要
        self.userBodySyncModel.userBodyModel = self.userBodyModel;
        //给同步模型计算
        [self.userBodySyncModel culculateStepwithStepArr:result];
        
        syncMotionResult(YES);
    } withFailure:^(NSError *error) {
        //同步超时
        NSLog(@"sync motion error =%@",[error description]);
        [self _cancelConnectPerial];
        if (self.failedBlock) {
            self.failedBlock(error);
        }
        
    }];

#endif
}//同步运动信息,主要是步数


-(void)syncSleepInfoForsyncResult:(ScanPerialsAndConnectBandedPerialBlock)syncSleepResult wihtSyncProgress:(SyncProgressBlock)progressBlock failed:(FailedBlock)failed{
    self.scanPerialsAndConnectBandedPerialBlock = syncSleepResult;
    self.failedBlock = failed;
    //同步之前先连接
    if (_connectedPerialBefore ) {
        
        self.connectTimeOut = 3;
        if (_connectedPerialBefore) {
            
            [self _conectPerial:_connectedPerialBefore];
        }
    }

#if TARGET_IPHONE_SIMULATOR
    
#else
    [[WKLBleSleep shareInstance] pubStartSyncSleepWithProgress:^(int progress) {
        NSLog(@"progress=%ld",(long)progress);
        progressBlock(progress);
    } withStartDay:nil withEndDay:nil withEqNumber:self.bangedPerialID withSuccess:^(id result) {
        for (NSDictionary *sleep in result) {
            NSLog(@"时间:%@,开始时间:%@,持续时间:%@,状态:%@",sleep[@"dateTime"],sleep[@"startTime"],sleep[@"sleepDuration"],sleep[@"sleepState"]);
        }
        //给同步模型计算
        [self.userBodySyncModel culculateSleepWithSleepArr:result];
        //记住这里要先计算，后返回，，返回后要取模型中的结果
        syncSleepResult(YES);
    } withFailure:^(NSError *error) {
        NSLog(@"sync sleep error=%@",[error description]);
        
        [self _cancelConnectPerial];
        if (self.failedBlock) {
            self.failedBlock(error);
        }
//        [self performSelector:@selector(_conectPerial:) withObject:_connectedPerialBefore afterDelay:0];
    }];
#endif

}//同步睡眠数据


-(void)setArmClockAtHour:(int)hour
                  minute:(int)minute
            reminderType:(RemindType)reminderType
                warnType:(WarnEventType)warnType
{
#if TARGET_IPHONE_SIMULATOR
    
#else
    [[WKLBleBaseOperation sharedInstance] pubStartWithRemindType:reminderType withWarnEventType:warnType withHour:hour withMin:minute withSuccess:^(id result) {
        
        NSLog(@"arm back : %@",result);
        
    } withFailure:^(NSError *error) {

        NSLog(@"set arm clock error=%@",[error description]);
        
    }];
#endif

    
}//设置闹钟，






-(void)setLongSeatingRemindingFromBeginHour:(int)beginHour
                                beginMinute:(int)beginMinute
                                    endHour:(int)endHour
                                  endMinute:(int)endMinute
                                   duration:(int)durationMinutes
                               reminderType:(RemindType)reminderType
                               withWarnType:(WarnEventType)warnType
{
    //利用设置间隔闹钟的方式
    //闹钟次数
    int beginMinutes = beginHour * 60 + beginMinute;
    int endMinutes = endHour * 60 + endMinute;
    int lockTime = (endMinutes - beginMinutes ) / durationMinutes;
    int minutes = beginMinutes;
    for (int i=0; i<lockTime; i++,minutes += i * durationMinutes ) {
    
        int hour = minutes / 60;
        int minute = minutes %60;
        //设置间隔闹钟
        [self setArmClockAtHour:hour minute:minute reminderType:RemindTypeClock warnType:WarnEventTypeOpen];
    }
    
}//久坐提醒


/**
 *  清除绑定设备--
 */
-(void)clearBanded {

    self.bangedPerialUUID = nil;
    self.bangedPerialID = nil;
    
    //清除绑定设备
    _connectedPerialBefore = nil;
//    UserDefaultSetObjectOfKey(nil, BANDED_PERIAL_KEY);
    
    //清空绑定设备的uuid,id
    UserDefaultSetObjectOfKey(nil, BANDED_PERIAL_UIID_KEY);
    [UserDefault synchronize];
    UserDefaultSetObjectOfKey(nil, BANDED_PERIAL_ID_KEY);
    [UserDefault synchronize];
    
    //断开连接
    [self _cancelConnectPerial];
    

    
}//解除绑定


#pragma mark ----------------初始化闹钟提醒----------------
-(void)_intArmLockInfo{
    
    //喝水
    [self _setDrinkWaterColock];
    //起床
    [self _setAwakerColock];
    //久坐提醒
    [self _setLongTimeReminderColock];
    
}


-(void)_setDrinkWaterColock{

    //获取喝水闹钟列表
    [_lkDBHelper search:[DrinkWaterMoel class] where:nil orderBy:nil offset:0 count:100 callback:^(NSMutableArray *array) {
        
        //遍历并设置闹钟
        for (DrinkWaterMoel *model in array) {
          
            NSString *hour = [model.drinkwaterTime substringWithRange:NSMakeRange(0, 2)];
            NSString *minute = [model.drinkwaterTime substringWithRange:NSMakeRange(3, 2)];
            //设置闹钟
            [self setArmClockAtHour:[hour intValue] minute:[minute intValue] reminderType:RemindTypeDrink warnType:WarnEventTypeOpen];
        }
        
    }];
    
}//喝水闹钟




-(void)_setAwakerColock{
    
    //获取起床闹钟列表
    [_lkDBHelper search:[GetAwakeModel class] where:nil orderBy:nil offset:0 count:100 callback:^(NSMutableArray *array) {
        //遍历并设置闹钟
        for (GetAwakeModel *model in array) {
            
            NSString *hour = [model.awakeTime substringWithRange:NSMakeRange(0, 2)];
            NSString *minute = [model.awakeTime substringWithRange:NSMakeRange(3, 2)];
            //设置闹钟
            [self setArmClockAtHour:[hour intValue] minute:[minute intValue] reminderType:RemindTypeClock warnType:WarnEventTypeOpen];
        }
    }];

}//起床闹钟




-(void)_setLongTimeReminderColock{

    //获取久坐提醒表
   [_lkDBHelper search:[LongTimeSeatReminderModel class] where:nil orderBy:nil offset:0 count:100 callback:^(NSMutableArray *array) {
       
        //遍历设置久坐提醒
       for (LongTimeSeatReminderModel *model in array) {
           
           NSString * beginHour = [model.beginTime substringWithRange:NSMakeRange(0, 2)];
           NSString * beginMinute = [model.beginTime substringWithRange:NSMakeRange(3, 2)];
           NSString * endHour = [model.endTime substringWithRange:NSMakeRange(0, 2)];
           NSString * endMinute = [model.endTime substringWithRange:NSMakeRange(3, 2)];
           
           
           [self setLongSeatingRemindingFromBeginHour:[beginHour intValue] beginMinute:[beginMinute intValue] endHour:[endHour intValue] endMinute:[endMinute intValue] duration:[model.duraTime intValue] reminderType:RemindTypeSedentary withWarnType:WarnEventTypeOpen];
           
       }
       
   }];
    

}//久坐提醒







@end
