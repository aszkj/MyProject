//
//  RTTakeMoneyViewModel.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "RTTakeMoneyViewModel.h"
#import <MJExtension/MJExtension.h>

@interface RTTakeMoneyViewModel ()

@property NSInteger usrType;

@end

@implementation RTTakeMoneyViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.usrType = 1;
    }
    return self;
}

- (void)setCashPayment:(NSString *)cashPayment {
    if ([cashPayment isEqualToString:@"支付宝"]) {
        _cashPayment = @"alipay";
    } else {
        _cashPayment = @"chinabank";
    }
}

- (RACCommand *)takeMoneyCommand {
    if (_takeMoneyCommand == nil) {
        _takeMoneyCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[[MerchantClient takeMoneySignalSignal:self.cashAmount payment:self.cashPayment userName:self.cashName bank:self.cashBank account:self.cashAccount password:self.cashPassword info:self.cashInfo usrType:@(self.usrType)]
                    doNext:^(id x) {
                        if (self.pushBlock) self.pushBlock();
                    }] doError:^(NSError *error) {
                        self.error = error;
                    }];
        }];
    }

    return _takeMoneyCommand;
}

- (RACCommand *)getBankInfoCommand {
    if (!_getBankInfoCommand) {
        _getBankInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[[MerchantClient getBankInfo:self.usrType] doNext:^(UsersBankInfoGetResponse *response) {
                StoreBank *storeBank = [StoreBank objectWithKeyValues:(NSDictionary *)response.storeBankInfo];
                self.cashBank = storeBank.bankName;
                self.cashAccount = storeBank.bankCAccount;
                self.cashName = storeBank.bankAccountName;
            }] doError:^(NSError *error) {
                self.error = error;
            }];
        }];
    }
    return _getBankInfoCommand;
}

- (RACCommand *)getYunbiCommand {
    if (!_getYunbiCommand) {
        _getYunbiCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[[MerchantClient yunbiInfoSignal] doNext:^(id x) {
                GroupAvailableBalanceGetResponse *response = (GroupAvailableBalanceGetResponse *)x;
                self.balance = response.balance;
            }] doError:^(NSError *error) {
                self.error = error;
            }];
        }];
    }
    return _getYunbiCommand;
}

@end
