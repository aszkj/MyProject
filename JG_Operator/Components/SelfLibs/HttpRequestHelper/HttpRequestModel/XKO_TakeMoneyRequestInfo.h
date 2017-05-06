//
//  XKO_TakeMoneyRequestInfo.h
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_BaseHttpRequestModel.h"

@interface XKO_TakeMoneyRequestInfo : XKO_BaseHttpRequestModel

/**
 * 提现金额
 */
@property (nonatomic, readwrite, copy) NSNumber *api_money;
/**
 * 密码
 */
@property (nonatomic, readwrite, copy) NSString *api_password;

- (id)initWithPageSize:(NSNumber *)money pageNum:(NSString *)password methordName:(NSString *)methordName;

@end
