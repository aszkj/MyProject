//
//  GloableEmerator.h
//  jingGang
//
//  Created by 张康健 on 15/7/27.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#ifndef jingGang_GloableEmerator_h
#define jingGang_GloableEmerator_h

typedef enum : NSUInteger {
    HeartRateTest,      //心率
    BloodPressureTest,  //血压
    BloodOxyen,         //血氧
} BloodTestType;

typedef enum : NSUInteger {
    EyeSightEditType, //视力编辑
    HeatRateEditType, //心率编辑
    BloodOxenEditType,//血氧编辑
    LungCapacityEditType,//肺活量编辑
    BloodPressureEditType,//血压编辑
    HearingEditType        //听力编辑
}TestEditType;

typedef enum : NSUInteger {
    FigureType,        //形体
    ZhengZhuangType,   //症状
    FoodCalculatorType //食物计算器
} ListType;


typedef enum : NSUInteger {
    WxPayType,          //微信支付
    AliPayType,         //ali支付
}PayType;

#define WXPay @"wx_app"
#define AliPay @"alipay_app"



#endif
