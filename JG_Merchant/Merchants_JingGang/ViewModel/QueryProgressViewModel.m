//
//  QueryProgressViewModel.m
//  Merchants_JingGang
//
//  Created by ray on 15/9/16.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "QueryProgressViewModel.h"

@implementation QueryProgressViewModel

- (RACCommand *)queryProgressCommand {
    if (_queryProgressCommand == nil) {
        _queryProgressCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[[MerchantClient queryStoreStatus] doNext:^(id x) {
                GroupQueryStoreStatusResponse *respone = (GroupQueryStoreStatusResponse *)x;
                self.applyInfo = [StoreApplyInfo objectWithKeyValues:respone.applyInfo];
            }] doError:^(NSError *error) {
                self.error = error;
            }];
        }];
    }
    return _queryProgressCommand;
}

@end
