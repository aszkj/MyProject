//
//  NLAccount.h
//  mpos
//
//  Created by su on 13-6-16.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @class
 @abstract 账号对象
 @discussion 返回方式决定于具体的实现。其中，{{@link #acctId}不能确保是可以交易的完整账号。可以带有掩码保护。dentityHash是可以用于标示账户唯一.
 */
@interface NLAccount : NSObject {
    
}
@property (nonatomic, copy) NSString *acctId; // 获得一个可能有掩码保护的账号
@property (nonatomic, copy) NSString *identityHash; // 可以用于标示唯一账号特征.SHA-1,128位,16字节,转换成32个HEX ASCII码表示.
- (id)initWithAcctId:(NSString *)acctId identityHash:(NSString *)identityHash;

@end
