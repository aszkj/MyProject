//
//  TakeMoneyViewModel.m
//  Operator_JingGang
//
//  Created by ray on 15/9/18.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "TakeMoneyViewModel.h"

@interface TakeMoneyViewModel ()

@property NSInteger usrType;

@end


@implementation TakeMoneyViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.usrType = 2;
        @weakify(self)
        RACSignal *isExcuting = [RACSignal
                                 combineLatest:@[
                                                 self.getYunbiCommand.executing,
                                                 self.takeMoneyCommand.executing,
                                                 self.getBankInfoCommand.executing
                                                 ]
                                 reduce:^(NSNumber *getYunbiExcuting,NSNumber *takeMoneyExcuting,NSNumber *getBankInfoExcuting) {
                                     return @(getYunbiExcuting.boolValue || takeMoneyExcuting.boolValue || getBankInfoExcuting.boolValue);
                                 }];
        
        [isExcuting subscribeNext:^(NSNumber *executing) {
            @strongify(self)
            self.isExcuting = executing.boolValue;
        }];
    }
    return self;
}

- (RACCommand *)takeMoneyCommand {
    if (_takeMoneyCommand == nil) {
        _takeMoneyCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[[OperatorClient takeMoneySignalSignal:self.cashAmount payment:self.cashPayment userName:self.cashName bank:self.cashBank account:self.cashAccount password:self.cashPassword info:self.cashInfo usrType:@(self.usrType)]
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
            return [[[OperatorClient getBankInfo:self.usrType] doNext:^(UsersBankInfoGetResponse *response) {
                OperatorBank *storeBank = [OperatorBank objectWithKeyValues:(NSDictionary *)response.operatorBankInfo];
                self.cashBank = storeBank.bankName;
                self.cashAccount = storeBank.bankNo;
                self.cashName = storeBank.userName;
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
            return [[[OperatorClient yunbiInfoSignal] doNext:^(id x) {
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
