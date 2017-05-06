//
//  NLPinInputConstants.h
//  MTypeSDK
//
//  Created by su on 14-4-14.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @enum
 @abstract 密码输入时,需要对应密码的账号作为输入条件.<p>
 若类型为{@link #USE_ACCOUNT},则表示密码输入时,对应的账号为原始账号.<p>
 若类型为{@link #USE_ACCT_HASH},则表示输入密码时,对应的账号是之前刷卡所返回的acctHashId.<p>
 @constant NLAccountInputTypeUserAccount 输入的是账户
 @constant NLAccountInputTypeUserAcctHash 输入的是账户hash值
 @constant NLAccountInputTypeUnuseAcct 无账户模式
 @constant NLAccountInputTypePinBlock pin block,直接计算
 */
typedef enum {
    NLAccountInputTypeUserAccount,
    NLAccountInputTypeUserAcctHash,
    NLAccountInputTypeUnuseAcct,
    NLAccountInputTypePinBlock,
}NLAccountInputType;

/*!
 @enum
 @abstract 加密方式
 @since 1.0
 @constant NLEncryptTypeCBC 使用CBC方式
 @constant NLEncryptTypeECB 使用ECB方式
 @constant NLEncryptTypeDisperseCBC 使用CBC 分散密钥后的工作密钥
 @constant NLEncryptTypeDisperseECB 使用ECB方式 分散密钥后的工作密钥
 */
typedef enum {
    NLEncryptTypeCBC,
    NLEncryptTypeECB,
    NLEncryptTypeDisperseCBC,
    NLEncryptTypeDisperseECB
}NLEncryptType;

typedef enum {
    NLPinManageTypeMKSK,
    NLPinManageTypeDUKPT,
    NLPinManageTypeFIXED
}NLPinManageType;

/*!
 @enum
 @abstract 主密钥传输使用的方式
 @constant NLKekUsingTypeTR31_Block USE TR31 block
 @constant NLKekUsingTypeEncrypt_TMK USE ENCRYPT TMK
 @constant NLKekUsingTypePrivateKey 主密钥采用发行方私钥加密
 @constant NLKekUsingTypeMainKey 使用主密钥加密主密钥
 */
typedef enum {
    NLKekUsingTypeTR31_Block,
    NLKekUsingTypeEncrypt_TMK,
    NLKekUsingTypePrivateKey,
    NLKekUsingTypeMainKey
}NLKekUsingType;

/*!
 @enum
 @abstract MAC摘要算法
 @constant NLMacAlgorithmX99
 @constant NLMacAlgorithmX919
 @constant NLMacAlgorithmECB
 @constant NLMacAlgorithm9606
 @constant NLMacAlgorithmDisperseX99 分散X99
 @constant NLMacAlgorithmDisperseX919 分散X919
 @constant NLMacAlgorithmDisperseECB 分散ECB
 @constant NLMacAlgorithmDisperse9606 分散9606
 @constant NLMacAlgorithmHanxin 明文分散数据-翰鑫算法
 */
typedef enum {
    NLMacAlgorithmX99,
    NLMacAlgorithmX919,
    NLMacAlgorithmECB,
    NLMacAlgorithm9606,
    NLMacAlgorithmDisperseX99,
    NLMacAlgorithmDisperseX919,
    NLMacAlgorithmDisperseECB,
    NLMacAlgorithmDisperse9606,
    NLMacAlgorithmHanxin
} NLMacAlgorithm;
