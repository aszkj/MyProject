//
//  XKO_OperatorInvitationCodeRequestInfo.m
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/30.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_OperatorInvitationCodeRequestInfo.h"

@implementation XKO_OperatorInvitationCodeRequestInfo

- (id)initWithMethordName:(NSString *)methordName {
    
    self = [super init];
    if (methordName) {
        self.requestMethordName = methordName;
    }
    
    return self;
}

@end
