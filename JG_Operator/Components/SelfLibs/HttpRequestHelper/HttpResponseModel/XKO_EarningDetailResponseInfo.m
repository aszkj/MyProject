//
//  XKO_EarningDetailResponseInfo.m
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_EarningDetailResponseInfo.h"
#import "NSString+BlankString.h"

@implementation XKO_EarningDetailResponseInfo

- (void)setCreateTime:(NSString *)createTime {
    _createTime = [NSString getTime:createTime];
}

@end
