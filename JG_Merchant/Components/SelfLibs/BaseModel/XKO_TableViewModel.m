//
//  TableViewModel.m
//  Merchants_JingGang
//
//  Created by ray on 15/9/15.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_TableViewModel.h"

@implementation XKO_TableViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.optype = @(2);
        self.pageSize = @(10);
        self.pageNum = @(1);
    }
    
    return self;
}

- (void)addNewData:(NSArray *)newArray
{
    if (newArray.count > 0) {
        self.pageNum = @(self.pageNum.integerValue+1);
        NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self.dataSource];
        [mutableArray addObjectsFromArray:newArray];
        if ([self.pageNum intValue] == 2)
        {
            self.dataSource = newArray;
        }
        else
        {
            self.dataSource = mutableArray;
        }
    } else {
        self.isNoMoreData = YES;
    }
}


- (RACCommand *)footerRefreshCommand {
    if (_footerRefreshCommand == nil) {
        @weakify(self)
        _footerRefreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            self.isNoMoreData = NO;
            IMP imp = [self methodForSelector:self.footerSelector];
            RACSignal*(*func)(id, SEL) = (void *)imp;
            return func(self, self.footerSelector);
        }];
    }
    return _footerRefreshCommand;
}

- (RACCommand *)headerRefreshCommand {
    if (_headerRefreshCommand == nil) {
        @weakify(self)
        _headerRefreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            self.isNoMoreData = NO;
            IMP imp = [self methodForSelector:self.headerSelector];
            RACSignal*(*func)(id, SEL) = (void *)imp;
            return func(self, self.headerSelector);
        }];
    }
    return _headerRefreshCommand;
}

@end
