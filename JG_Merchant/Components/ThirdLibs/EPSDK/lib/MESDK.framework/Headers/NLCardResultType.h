//
//  NLCardResultType.h
//  MTypeSDK
//
//  Created by wanglx on 15/5/15.
//  Copyright (c) 2015年 newland. All rights reserved.
//

typedef enum {
    /**
     * 磁卡刷卡成功
     */
    NLCardResultType_SWIPE_CARD_SUCCESS,
    /**
     * 磁卡刷卡完成，但是刷卡失败
     */
    NLCardResultType_SWIPE_CARD_FAILED,
    /**
     * 非接卡为A卡
     */
    NLCardResultType_NCCARD_ACARD,
    /**
     * 非接卡为B卡
     */
    NLCardResultType_NCCARD_BCARD,
    /**
     * 非接卡为M1卡
     */
    NLCardResultType_NCCARD_M1CARD
}NLCardResultType;
