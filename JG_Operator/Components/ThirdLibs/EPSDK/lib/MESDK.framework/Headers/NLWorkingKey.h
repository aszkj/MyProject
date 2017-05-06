//
//  NLWorkingKey.h
//  mpos
//
//  Created by su on 13-6-16.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @enum
 @abstract 工作密钥类型
 @since 1.0
 @constant NLWorkingKeyTypeDataEncrypt 数据加密类型
 @constant NLWorkingKeyTypePinInput 密码加密类型
 @constant NLWorkingKeyTypeMAC 计算摘要的密钥类型
 @constant NLWorkingKeyTypeTrace 磁道加密的密钥类型
 */
typedef enum {
    NLWorkingKeyTypeDataEncrypt,
    NLWorkingKeyTypePinInput,
    NLWorkingKeyTypeMAC,
    /*!
     @deperated at 1.0.6
     */
    NLWorkingKeyTypeTrace
}NLWorkingKeyType;

/*!
 @class
 @abstract 工作密钥
 @discussion
 */
@interface NLWorkingKey : NSObject
@property (nonatomic, assign) BOOL isUsingOutWK;
@property (nonatomic, assign) int index; // 工作密钥索引
@property (nonatomic, copy) NSData *wk;
- (id)initWithIndex:(int)index;
- (id)initWithIndex:(int)index wk:(NSData*)wk;

@end
