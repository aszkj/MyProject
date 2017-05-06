//
//  BlueToothManager.m
//  HuiKangEJia
//
//  Created by 丁炯 on 15/1/27.
//  Copyright (c) 2015年 ZKHK. All rights reserved.
//

#import "BlueToothManager.h"

@interface BlueToothManager ()
{
    NSTimer *_timer;
}
@end

@implementation BlueToothManager

-(void)dealloc{
}
//初始化
-(id)initWithDuration:(NSTimeInterval)duration delegate:(id)delegate peripheralType:(NSString *)type{
    self =[super init];
    if (self){
            //初始化 gcd 主线程和子线程
            dispatch_queue_t slaverQueue =dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            //初始化中心角色 和外设
            _manager =[[CBCentralManager alloc] initWithDelegate:self queue:slaverQueue];

            //设置超时时间
            _outTiming =duration;
            //设置代理usingdispatch_queue_create
            _delegate =delegate;
            //设置搜索类型
            _peripheralType =type;
            //初始化数组
            _peripheralArray =[[NSMutableArray alloc] init];
            //初始化data
            _updateData =[[NSMutableData alloc] init];
    }
    return self;
}
//开始扫描外设
-(void)scanForPeripheral{
    //扫描所有可被发现的设备
    [self.manager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey :@YES}];
    
    _timer =[NSTimer scheduledTimerWithTimeInterval:_outTiming target:self selector:@selector(timeOut) userInfo:nil repeats:YES];
}
//蓝牙搜索蓝牙超时
-(void)timeOut{
    //停止搜索蓝牙
    [self.manager stopScan];
    //关闭时钟,移除对象,确保关闭
    [_timer invalidate];_timer =nil;
    
    if ([_delegate respondsToSelector:@selector(blueToothScanForPeripheralTimeOutManager:)]){
        //通知外部,搜索蓝牙超时
        [_delegate blueToothScanForPeripheralTimeOutManager:self];
    }
}
//外部点击取消的时候
-(void)stopScan{
    //停止搜索蓝牙
    [self.manager stopScan];
    //关闭时钟,移除对象,确保关闭
    [_timer invalidate];_timer =nil;
    //取消的时候将数组里面的所有对象移除
    [self.peripheralArray removeAllObjects];
}
//连接指定的设备
-(void)connectPeripheral:(CBPeripheral *)peripheral{
    [self.manager connectPeripheral:peripheral options:nil];
}
//断开蓝牙连接
-(void)cancelPeripheral{
    [self.manager cancelPeripheralConnection:self.peripheral];
}
#pragma mark- CBCentralManagerDelegate
//获取自身设备的蓝牙状态,系统自会操作
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
        NSLog(@"蓝牙已打开,请扫描设备");
            break;
        default:
            break;
    }
}
//扫描外设,扫描到外设之后,调用自定义的代理方法
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    //搜索对应类型的设备,搜索到之后才会加入数组;没搜到,搜索超时.
    if ([peripheral.name isEqualToString:_peripheralType]){
        //遍历数组,防止里面拥有重复的对象;在搜索到第一个有效设备的时候就关闭搜索超时定时器.
        if (self.peripheralArray.count ==0){
            [self.peripheralArray addObject:peripheral];
            //关闭扫描超时的计时器,在没有选定连接设备之前会一直扫描
            [_timer invalidate];_timer =nil;
            //调用自定义代理方法,扫描到外设,通知外部,选择将要连接的外设,必须实现
            [_delegate blueToothManager:self peripherals:self.peripheralArray];
        }
        else{
            for (int i=0; i<self.peripheralArray.count; i++){
                //判断数组里面是否拥有重复的数据
                if (![self.peripheralArray containsObject:peripheral]){
                    [self.peripheralArray addObject:peripheral];
                    //调用自定义代理方法,扫描到外设,通知外部,选择将要连接的外设,必须实现
                    [_delegate blueToothManager:self peripherals:self.peripheralArray];
                }//添加一次数据才刷新一次表,防止重复地无效刷新
            }
        }
    }
}
//连接成功,开始发现服务
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    //连接成功后,停止搜索
    [self.manager stopScan];
    //提醒外部,连接成功,开始发现服务
    [_delegate blueToothManager:self connectPeripheral:self.peripheral];
    peripheral.delegate=self;
}
//连接失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    //连接失败,停止搜索
    [self.manager stopScan];
    //提示外部,连接失败,
    if ([_delegate respondsToSelector:@selector(blueToothManager:failToConnectPeripheral:)]){
        [_delegate blueToothManager:self failToConnectPeripheral:self.peripheral];
    }
}
#pragma mark- CBPeripheralDelegate
//已经发现服务,确认服务
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    for (CBService *service in peripheral.services){
        [peripheral discoverCharacteristics:nil forService:service];
    }
}
//寻找Characteristics,处理需要得到的服务
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    [_delegate blueToothManager:self peripheral:peripheral characteristcsForService:service];
}
//从蓝牙设备处读取数据
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    [_delegate blueToothManager:self didUpdateValueForCharacteristic:characteristic TransmissionData:characteristic.value];
}

- (void)peripheralReadRSSI:(CBPeripheral *)periphetal {
    
}

-(void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error {
    NSLog(@"\n%@", [NSString stringWithFormat:@":%@,强度:%ddB", peripheral, [RSSI intValue]]);

}


@end
