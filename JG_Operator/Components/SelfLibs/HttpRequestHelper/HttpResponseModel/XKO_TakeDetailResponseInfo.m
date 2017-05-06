//
//  XKO_TakeDetailResponseInfo.m
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_TakeDetailResponseInfo.h"
#import "NSString+BlankString.h"

@implementation XKO_TakeDetailResponseInfo


- (void)setAddTime:(NSString *)addTime {
    _addTime = [NSString getTime:addTime];
}

- (void)setCashStatus:(NSNumber *)cashStatus {
    _cashStatus = cashStatus;
    _cashStatusString = [self getCashState:cashStatus.integerValue];
}

//获取审核状态
- (NSString *)getCashState:(NSInteger)stateCode {
    NSString *state = @"";
    if (stateCode == 0) {
        state = @"审核中";
    } else if (stateCode == 1) {
        state = @"已完成";
    } else if (stateCode == -1) {
        state = @"已拒绝";
    }
    return state;
}

@end
