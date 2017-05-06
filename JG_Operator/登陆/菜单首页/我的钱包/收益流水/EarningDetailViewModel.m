//
//  EarningDetailViewModel.m
//  Operator_JingGang
//
//  Created by ray on 15/9/18.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "EarningDetailViewModel.h"
#import "XKO_EarningDetailResponseInfo.h"

@implementation EarningDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"收益明细";
        self.titleArray = @[@"商户名称",@"交易时间",@"收益金额",@"收益类型"];
        self.footerText = @"如需收益明细列表, 表请登陆云e生WEB端后台查看详情";
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
    return [[[self.client operatorProfitListRequestSize:self.pageSize pageNum:self.pageNum] doNext:^(NSArray *x) {
        @strongify(self);
        [self addNewData:x];
    }] doError:^(NSError *error) {
        self.error = error;
    }];
}

@end
