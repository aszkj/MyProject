//
//  NLLoadPKResultCode.h
//  MTypeSDK
//
//  Created by wanglx on 15/4/22.
//  Copyright (c) 2015年 newland. All rights reserved.
//

#ifndef MTypeSDK_NLLoadPKResultCode_h
#define MTypeSDK_NLLoadPKResultCode_h

typedef enum
{
    /**
     * 成功
     */
    NLLoadPKResultCodeSUCCESS,
    /**
     * 失败
     */
    NLLoadPKResultCodeFAILED,
    /**
     * 公钥长度错误
     */
    NLLoadPKResultCodePKLENGTH_ERROR,
    /**
     * MAC校验错误
     */
    NLLoadPKResultCodeMAC_ERROR,
    /**
     * 未知公钥索引
     */
    NLLoadPKResultCodeUNKNOWPKINDEX_ERROR,
    /**
     * 未知主密钥索引
     */
    NLLoadPKResultCodeUNKNOWMKINDEX_ERROR,
    /**
     * 公钥数据长度错误
     */
    NLLoadPKResultCodePKDATALENGTH_ERROR
}NLLoadPKResultCode;

#endif
