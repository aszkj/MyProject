//
//  MERHomePageViewModel.m
//  jingGang
//
//  Created by ray on 15/10/21.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "MERHomePageViewModel.h"
#import "MERHomePageEntity.h"

@implementation MERHomePageViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.footerSelector = @selector(reportListAddSignal);
        self.headerSelector = @selector(reportListResetSignal);
    }
    return self;
}

- (RACSignal *)reportListResetSignal {
    self.pageNum = @(1);
    self.isNoMoreData = NO;
    return self.reportListAddSignal;
}

- (RACSignal *)reportListAddSignal {
    @weakify(self)
    return [[[self.client RACReportCheckList:self.pageSize pageNum:self.pageNum] doNext:^(NSArray *x) {
        @strongify(self);
        [self addNewData:x];
    }] doError:^(NSError *error) {
        self.error = error;
    }];
}



@end
