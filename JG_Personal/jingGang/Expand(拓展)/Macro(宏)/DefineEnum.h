//
//  DefineEnum.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/8.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#ifndef jingGang_DefineEnum_h
#define jingGang_DefineEnum_h


//登录注册返回结果：
typedef enum
{
    General_Success    = 0000,//成功
    General_Psw_Error  = 1001,//密码错误
    General_Error      = 1004,//参数错误
}GeneralQuestResult;

//闪光灯flashMode 三种类型值：
//typedef enum {
//    AVCaptureFlashModeOff  = 0,
//    AVCaptureFlashModeOn   = 1,
//    AVCaptureFlashModeAuto = 2
//}AVCaptureFlashMode;

typedef enum : NSUInteger {
    ShoppingPay,    //商城支付
    O2OPay,         //O2O支付
    IntegralPay,    //积分支付
    ClouldPay       // 云币支付
}JingGangPay;





#endif
