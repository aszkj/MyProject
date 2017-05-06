//
//  AcceptOrdeHeaderEntity.m
//  WeimiSP
//
//  Created by 鹏 朱 on 16/2/22.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "AcceptOrdeHeaderEntity.h"

@implementation AcceptOrdeHeaderEntity

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = super.init;
    if (self) {
        _time = dictionary[@"time"];
        _acceptOrderNum = dictionary[@"acceptOrderNum"];
        _income = dictionary[@"income"];
        _completeOrderNum = dictionary[@"completeOrderNum"];
        _completeOrderPercentage = dictionary[@"completeOrderPercentage"];
    }
    return self;
}

@end
