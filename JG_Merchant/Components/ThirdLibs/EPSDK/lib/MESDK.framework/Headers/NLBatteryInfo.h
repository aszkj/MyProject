//
//  NLBatteryInfo.h
//  MTypeSDK
//
//  Created by wanglx on 14-5-27.
//  Copyright (c) 2014年 suzw. All rights reserved.
//
typedef enum
{
    NLBatteryInfo_CHARGE_STAT_NO,          //未充电
    NLBatteryInfo_CHARGE_STATE_USB_NORMAL,  //USB 普通充电
    NLBatteryInfo_CHARGE_STATE_USB_FAST,    //USB 快速充电(暂不支持)
    NLBatteryInfo_CHARGE_STATE_POWER        //适配器充电
}NLBatteryInfo_CHARGE_STATE;

typedef enum
{
    NLBatteryInfo_USB_STATE_NOPLUG,       //未插入
    NLBatteryInfo_USB_STATE_PLUG          //插入
}NLBatteryInfo_USB_STATE;
#import <Foundation/Foundation.h>

@protocol NLBatteryInfo <NSObject>
-(int)batteryPercent;
-(int)batteryLevel;
-(NLBatteryInfo_CHARGE_STATE)batteryChargeState;
-(BOOL)isCharging;
-(NLBatteryInfo_USB_STATE)batteryUsbState;
-(BOOL)isUsbConnected;
@end
