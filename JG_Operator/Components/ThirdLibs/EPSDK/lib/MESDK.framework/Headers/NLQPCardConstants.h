//
//  NLQPCardConstants.h
//  MTypeSDK
//
//  Created by su on 14-4-14.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 非接寻卡类型
 */
typedef enum {
    NLQPCardTypeACARD,
    NLQPCardTypeBCARD,
    NLQPCardTypeM1CARD,
    NLQPCardTypeANYCARD,
    NLQPCardTypeABCARD,
    NLQPCardTypeAM1CARD,
    NLQPCardTypeBM1CARD,
    NLQPCardTypeABM1CARD
} NLQPCardType;

/**
 * 非接key模式
 */
typedef enum {
    NLQPKeyModeKEYA_0X60,
    NLQPKeyModeKEYA_0X00,
    NLQPKeyModeKEYB_0X61,
    NLQPKeyModeKEYB_0X01
} NLQPKeyMode;
