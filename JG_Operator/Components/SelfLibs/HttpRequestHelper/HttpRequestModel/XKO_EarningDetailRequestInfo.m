//
//  XKO_EarningDetailRequestInfo.m
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_EarningDetailRequestInfo.h"

@implementation XKO_EarningDetailRequestInfo

- (id)initWithPageSize:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum methordName:(NSString *)methordName{
    self = [super init];
    _api_pageSize = pageSize;
    _api_pageNum = pageNum;
    if (methordName) {
        self.requestMethordName = methordName;
    }
    
    return self;
}

@end
