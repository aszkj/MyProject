//
//  NLKSNLoadResultCode.h
//  MTypeSDK
//
//  Created by wanglx on 15/4/23.
//  Copyright (c) 2015年 newland. All rights reserved.
//

#ifndef MTypeSDK_NLKSNLoadResultCode_h
#define MTypeSDK_NLKSNLoadResultCode_h

typedef enum
{
    /**
     * 成功
     */
    NLKSNLoadResultCodeSUCCESS,
    /**
     * 失败
     */
    NLKSNLoadResultCodeFAILED,
    /**
     * 校验值错误
     */
    NLKSNLoadResultCodeKCV_ERROR,
    /**
     * 错误
     */
    NLKSNLoadResultCodeERROR,
    /**
     * 密钥索引无效
     */
    NLKSNLoadResultCodeKEY_INDEX_ERROR,
    /**
     * 主密钥长度错误
     */
    NLKSNLoadResultCodeMAINKEY_LENGTH_ERROR,
    /**
     * 无效的TR31格式
     */
    NLKSNLoadResultCodeUNKNOW_TR31_ERROR
}NLKSNLoadResultCode;

#endif
