//
//  NLLoadPKType.h
//  MTypeSDK
//
//  Created by wanglx on 15/4/22.
//  Copyright (c) 2015年 newland. All rights reserved.
//

#ifndef MTypeSDK_NLLoadPKType_h
#define MTypeSDK_NLLoadPKType_h

/**
 *  使用传输密钥加密公钥  NLLoadPKTypeTRANSFERKEY_TYPE
 *  使用主密钥加密公钥    NLLoadPKTypeMAINKEY_TYPE
 *  不加密              NLLoadPKTypeNOKEY_TYPE
 */
typedef enum
{
    NLLoadPKTypeTRANSFERKEY_TYPE,
    NLLoadPKTypeMAINKEY_TYPE,
    NLLoadPKTypeNOKEY_TYPE
    
}NLLoadPKType;

/**
 *  公钥长度为1024  NLLoadPKLenType1024
 *  公钥长度为2048  NLLoadPKLenType2048
 */
typedef enum
{
    NLLoadPKLenType1024,
    NLLoadPKLenType2048
    
}NLLoadPKLenType;

#endif
