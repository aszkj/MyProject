//
//  HomePageViewModel.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/12.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "HomePageViewModel.h"

@interface HomePageViewModel ()
@property (nonatomic) StoreIndex *merchant;

@end

@implementation HomePageViewModel

- (RACCommand *)merchantInfoCommand {
    if (!_merchantInfoCommand) {
        _merchantInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[[MerchantClient merchantInfoSignal] doNext:^(id x) {
                if (!self.active) return;
                GroupMerchantInfoResponse *respone = (GroupMerchantInfoResponse *)x;
                 self.merchant = [StoreIndex objectWithKeyValues:(NSDictionary *)respone.merchant];
            }] doError:^(NSError *error) {
                if (!self.active) return;
                self.error = error;
            }];
        }];
    }
    return _merchantInfoCommand;
}


@end
