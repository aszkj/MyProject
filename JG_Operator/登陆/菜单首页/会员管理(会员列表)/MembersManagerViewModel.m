//
//  membersManagerViewModel.m
//  Operator_JingGang
//
//  Created by ray on 15/9/18.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "MembersManagerViewModel.h"

@implementation MembersManagerViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"会员列表";
        self.footerSelector = @selector(memberListAddSignal);
        self.headerSelector = @selector(memberListResetSignal);
    }
    return self;
}

- (RACSignal *)memberListResetSignal {
    self.pageNum = @(1);
    self.isNoMoreData = NO;
    return self.memberListAddSignal;
}

- (RACSignal *)memberListAddSignal {
    @weakify(self)
    return [[[self.client operatorMemberListRequestSize:self.pageSize pageNum:self.pageNum] doNext:^(NSArray *x) {
        @strongify(self);
        [self addNewData:x];
    }] doError:^(NSError *error) {
        self.error = error;
    }];
}

@end
