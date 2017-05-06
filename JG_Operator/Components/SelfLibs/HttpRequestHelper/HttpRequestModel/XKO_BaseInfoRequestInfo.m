//
//  XKO_BaseInfoRequestInfo.m
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_BaseInfoRequestInfo.h"

@implementation XKO_BaseInfoRequestInfo

- (id)initWithMethordName:(NSString *)methordName {
    
    self = [super init];
    if (methordName) {
        self.requestMethordName = methordName;
    }
    
    return self;
}

@end
