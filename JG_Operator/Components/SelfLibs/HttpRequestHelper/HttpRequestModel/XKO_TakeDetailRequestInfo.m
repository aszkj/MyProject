//
//  XKO_TakeDetailRequestInfo.m
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_TakeDetailRequestInfo.h"

@implementation XKO_TakeDetailRequestInfo

- (id)initWithPageSize:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum{
    
    self = [super init];
    _api_pageSize = pageSize;
    _api_pageNum = pageNum;

    return self;
}

@end
