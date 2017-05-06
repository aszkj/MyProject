//
//  BlueToothManager.h
//  HuiKangEJia
//
//  Created by 丁炯 on 15/1/27.
//  Copyright (c) 2015年 ZKHK. All rights reserved.
//
//封装蓝牙功能模块的管理
#import <Foundation/Foundation.h>
//导入蓝牙功能模块
#import <CoreBluetooth/CoreBluetooth.h>

@protocol BlueToothManagerDelegate;

@interface BlueToothManager : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

//蓝牙中心设备
@property (nonatomic,retain) CBCentralManager *manager;
//搜索到的蓝牙设备(外设)
@property (nonatomic,retain) CBPeripheral *peripheral;
//设置搜索蓝牙超时时间
@property (nonatomic,assign) NSTimeInterval outTiming;
//设置搜索蓝牙的类型
@property (nonatomic,copy) NSString *peripheralType;
//manager的Tag值,以便区分多个manager
@property (nonatomic,assign) NSInteger tag;
//代理
@property (nonatomic,assign) id<BlueToothManagerDelegate>delegate;
//存放搜到的蓝牙设备
@property (nonatomic,retain) NSMutableArray *peripheralArray;
//蓝牙接收到的数据
@property (nonatomic,retain) NSMutableData *updateData;

//初始化方法
-(id)initWithDuration:(NSTimeInterval)duration delegate:(id)delegate peripheralType:(NSString *)type;
//开始扫描外设
-(void)scanForPeripheral;
//外部点击取消的时候
-(void)stopScan;
//连接蓝牙
-(void)connectPeripheral:(CBPeripheral *)peripheral;
//断开蓝牙连接
-(void)cancelPeripheral;

@end

@protocol BlueToothManagerDelegate <NSObject>

@required//必须实现的协议方法
//将扫描到的外设数据传给外部
-(void)blueToothManager:(BlueToothManager *)manager peripherals:(NSMutableArray *)peripherals;
//连接成功,开始发现服务
-(void)blueToothManager:(BlueToothManager *)manager connectPeripheral:(CBPeripheral *)peripheral;
//处理服务
-(void)blueToothManager:(BlueToothManager *)manager peripheral:(CBPeripheral *)peripheral characteristcsForService:(CBService *)service;
//从蓝牙接收到的数据
-(void)blueToothManager:(BlueToothManager *)manager didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic TransmissionData:(NSData *)data;

@optional//可选的协议方法
//搜索设备超时
-(void)blueToothScanForPeripheralTimeOutManager:(BlueToothManager *)manager;
//连接失败
-(void)blueToothManager:(BlueToothManager *)manager failToConnectPeripheral:(CBPeripheral *)peripheral;

@end