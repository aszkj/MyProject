//
//  NLKSNKeyType.h
//  MTypeSDK
//
//  Created by wanglx on 15/4/23.
//  Copyright (c) 2015年 newland. All rights reserved.
//

#ifndef MTypeSDK_NLKSNKeyType_h
#define MTypeSDK_NLKSNKeyType_h

typedef enum
{
    //使用tr31的格式
    NLKSNKeyTypeTR31_TYPE,
    //使用传输密钥加密DUKPT初始密钥格式
    NLKSNKeyTypeTRANSFERKEY_TYPE,
    //DUKPT初始密钥采用发行方私钥加密的格式
    NLKSNKeyTypeSELFKEY_TYPE,
    //使用主密钥加密DUKPT出是密钥的格式
    NLKSNKeyTypeMAINKEY_TYPE
}NLKSNKeyType;

#endif
