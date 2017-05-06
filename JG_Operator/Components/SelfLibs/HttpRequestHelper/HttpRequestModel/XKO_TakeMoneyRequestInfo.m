//
//  XKO_TakeMoneyRequestInfo.m
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_TakeMoneyRequestInfo.h"

@implementation XKO_TakeMoneyRequestInfo

- (id)initWithPageSize:(NSNumber *)money pageNum:(NSString *)password methordName:(NSString *)methordName{
    
    self = [super init];
    _api_money = money;
    _api_password = password;
    if (methordName) {
        self.requestMethordName = methordName;
    }

    return self;
}

@end
