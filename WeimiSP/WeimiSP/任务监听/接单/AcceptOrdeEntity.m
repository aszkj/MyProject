//
//  AcceptOrdeEntity.m
//  WeimiSP
//
//  Created by 鹏 朱 on 16/2/22.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "AcceptOrdeEntity.h"

@implementation AcceptOrdeEntity

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = super.init;
    if (self) {
        _message_time = dictionary[@"message_time"];
        _message_type = [dictionary[@"message_type"] integerValue];
        _message_content = dictionary[@"message_content"];
    }
    return self;
}

@end
