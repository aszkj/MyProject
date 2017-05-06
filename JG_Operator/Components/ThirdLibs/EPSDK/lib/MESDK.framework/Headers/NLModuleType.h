//
//  NLModuleType.h
//  mpos
//
//  Created by su on 13-6-21.
//  Copyright (c) 2013年 suzw. All rights reserved.
//
#import "NLFoundation.h"
/*!
 @enum
 @abstract 支持的模块类型
 @constant NLModuleTypeCommonLCD 液晶屏模块
 @constant NLModuleTypeCommonKeyboard 按键模块
 @constant NLModuleTypeCommonPinInput 密码键盘模块
 @constant NLModuleTypeCommonFileIO 文件IO操作模块（ME不支持）
 @constant NLModuleTypeCommonSwiper 磁条卡模块
 @constant NLModuleTypeCommonICCard IC卡模块
 @constant NLModuleTypeCommonNCCard 通用非接卡模块
 @constant NLModuleTypeCommonSecurity 安全模块
 @constant NLModuleTypeCommonPrinter 打印模块（ME不支持）
 @constant NLModuleTypeCommonEMV 通用EMV流程处理模块
 @constant NLModuleTypeCommonQPBOC QPBOC流程处理模块
 @constant NLModuleTypeCommonScanner 扫描仪（ME不支持）
 @constant NLModuleTypeCommonBuzzer 蜂鸣器（ME11不支持）
 @constant NLModuleTypeCommonIndicatorLight 指示灯（暂不支持）
 @constant NLModuleTypeCommonCardReader 读卡模块
 @constant NLModuleTypeCommonStore 存储类
 */
typedef enum {
    NLModuleTypeCommonLCD,
    NLModuleTypeCommonKeyboard,
    NLModuleTypeCommonPinInput,
    NLModuleTypeCommonFileIO,
    NLModuleTypeCommonSwiper,
    NLModuleTypeCommonICCard,
    NLModuleTypeCommonNCCard,
    NLModuleTypeCommonSecurity,
    NLModuleTypeCommonPrinter,
    NLModuleTypeCommonEMV,
    NLModuleTypeCommonQPBOC,
    NLModuleTypeCommonScanner,
    NLModuleTypeCommonBuzzer,
    NLModuleTypeCommonIndicatorLight,
    NLModuleTypeCommonCardReader,
    NLModuleTypeCommonStore
} NLModuleType;

/*!
 @method
 @abstract 获取具体某个模块的描述信息
 @param moduleType 模块枚举类型
 @discussion
 @return 模块对应描述信息
 */
static inline NSString* GetModuleTypeDescription(NLModuleType moduleType);

static inline NSString* GetModuleTypeDescription(NLModuleType moduleType)
{
    return [[NSArray arrayWithObjects:
             @"通用液晶设备",
             @"通用键盘输入设备",
             @"通用PIN输入设备",
             @"通用文件IO",
             @"通用刷卡器",
             @"通用IC卡读卡器",
             @"通用非接卡模块",
             @"通用设备外部安全认证模块",
             @"通用打印机",
             @"通用EMV流程处理",
             @"通用QPBOC",
             @"通用扫描头",
             @"通用蜂鸣器",
             @"通用指示灯",
             @"通用读卡设备",
             nil] objectAtIndex:moduleType];
}

