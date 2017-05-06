//
//  IntegralDetailViewModel.m
//  jingGang
//
//  Created by ray on 15/10/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "IntegralDetailViewModel.h"

@implementation IntegralDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"积分兑换订单详情";
        @weakify(self)
        RACSignal *excutingSignal =
        [RACSignal combineLatest:@[
                                   self.getDetailCommand.executing,
                                   self.getUserIntegralCommand.executing
                                   ]
                          reduce:^(
                                   NSNumber *getDetailExcuting,
                                   NSNumber *getIntegralExcuting
                                   ) {
                              return @(
                              getDetailExcuting.boolValue
                              || getIntegralExcuting.boolValue
                              );
                          }];
        [excutingSignal subscribeNext:^(NSNumber *x) {
            @strongify(self)
            self.isExcuting = [x boolValue];
        }];
    }
    return self;
}

- (RACCommand *)getDetailCommand {
    if (_getDetailCommand == nil) {
        @weakify(self)
        _getDetailCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [[[self.client RACGetIntegralOrderDetail:self.orederId] doNext:^(NSArray *x) {
                self.detail = x.firstObject;
            }] doError:^(NSError *error) {
                self.error = error;
            }];
        }];
    }
    
    return _getDetailCommand;
}

- (RACCommand *)getUserIntegralCommand {
    if (_getUserIntegralCommand == nil) {
        @weakify(self);
        _getUserIntegralCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [[[self.client RACGetUsersIntegral] doNext:^(NSArray *x) {
                self.userIntegral = x.firstObject;
            }] doError:^(NSError *error) {
                self.error = error;
            }];
        }];
    }
    return _getUserIntegralCommand;
}

@end
