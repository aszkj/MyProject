//
//  TakeDetailViewModel.m
//  Operator_JingGang
//
//  Created by ray on 15/9/18.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "TakeDetailViewModel.h"
#import "XKO_TakeDetailResponseInfo.h"

@implementation TakeDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"提现明细";
        self.titleArray = @[@"提现金额",@"提现时间",@"状态"];
        self.footerText = @"如需提现明细列表, 表请登陆云e生WEB端后台查看详情";
        self.footerSelector = @selector(takeListAddSignal);
        self.headerSelector = @selector(takeListResetSignal);
    }
    return self;
}

- (RACSignal *)takeListResetSignal {
    self.pageNum = @(1);
    self.isNoMoreData = NO;
    return self.takeListAddSignal;
}

- (RACSignal *)takeListAddSignal {
    @weakify(self)
    return [[[self.client operatorCashmoneyDetailsRequestSize:self.pageSize pageNum:self.pageNum] doNext:^(NSArray *x) {
        @strongify(self);
        [self addNewData:x];
    }] doError:^(NSError *error) {
        self.error = error;
    }];
}





@end
