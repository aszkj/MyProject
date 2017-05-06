//
//  NLICCardConstants.h
//  MTypeSDK
//
//  Created by su on 14-4-14.
//  Copyright (c) 2014年 suzw. All rights reserved.
//
/*!
 @enum
 @abstract ICCard 接口类型
 @constant NLICCardSlotIC1
 @constant NLICCardSlotIC2
 @constant NLICCardSlotIC3
 @constant NLICCardSlotSAM1
 @constant NLICCardSlotSAM2
 @constant NLICCardSlotSAM3
 */
typedef enum {
    NLICCardSlotIC1,
    NLICCardSlotIC2,
    NLICCardSlotIC3,
    NLICCardSlotSAM1,
    NLICCardSlotSAM2,
    NLICCardSlotSAM3
} NLICCardSlot;

/*!
 @enum
 @abstract ICCard 状态
 @constant NLICCardSlotStateNoCard 未插卡
 @constant NLICCardSlotStateCardInserted 卡已经插入
 @constant NLICCardSlotStateCardPowered 卡已经上电
 */
typedef enum {
    NLICCardSlotStateNoCard,
    NLICCardSlotStateCardInserted,
    NLICCardSlotStateCardPowered
} NLICCardSlotState;


/*!
 @enum
 @abstract IC卡类型
 @constant NLICCardTypeCPUCARD
 @constant NLICCardTypeAT24CXX
 @constant NLICCardTypeSLE44X2
 @constant NLICCardTypeSLE44X8
 @constant NLICCardTypeAT88SC102
 @constant NLICCardTypeAT88SC1604
 @constant NLICCardTypeAT88SC1608
 */
typedef enum {
    NLICCardTypeCPUCARD,
    NLICCardTypeAT24CXX,
    NLICCardTypeSLE44X2,
    NLICCardTypeSLE44X8,
    NLICCardTypeAT88SC102,
    NLICCardTypeAT88SC1604,
    NLICCardTypeAT88SC1608
} NLICCardType;
