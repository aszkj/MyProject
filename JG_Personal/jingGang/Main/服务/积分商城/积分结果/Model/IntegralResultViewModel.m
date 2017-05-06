//
//  IntegralResultViewModel.m
//  jingGang
//
//  Created by ray on 15/10/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "IntegralResultViewModel.h"

@implementation IntegralResultViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"积分商城";
    }
    return self;
}

- (void)setOrderNumber:(NSString *)orderNumber {
    _orderNumber = orderNumber;
    _orderNumberString = [NSString stringWithFormat:@"积分订单号：%@",orderNumber];
}

- (NSString *)orderNumberString {
    if (_orderNumberString == nil) {
        _orderNumberString = @"积分订单号：3124294(测试)";
    }
    return _orderNumberString;
}

@end
