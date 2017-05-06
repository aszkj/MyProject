//
//  XKO_MerchantManagerRequestInfo.m
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_MerchantManagerRequestInfo.h"

@implementation XKO_MerchantManagerRequestInfo

- (id)initWithMethordName:(NSString *)methordName {
    
    self = [super init];
    if (methordName) {
        self.requestMethordName = methordName;
    }
    
    return self;
}

@end
