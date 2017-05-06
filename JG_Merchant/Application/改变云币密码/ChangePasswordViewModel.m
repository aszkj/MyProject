//
//  ChangePasswordViewModel.m
//  Merchants_JingGang
//
//  Created by ray on 15/9/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "ChangePasswordViewModel.h"

@interface ChangePasswordViewModel ()

@property (nonatomic) RACCommand *usrInfoCommand;
@property (nonatomic) RACCommand *varifyCommand;
@property (nonatomic) RACCommand *changePasswordCommand;
@end

@implementation ChangePasswordViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"修改提现密码";
        @weakify(self);
        [[[RACSignal combineLatest:@[
                             self.usrInfoCommand.executing,
                             self.varifyCommand.executing,
                             self.changePasswordCommand.executing]
                          reduce:^(NSNumber *usrInfoExcuting,NSNumber *varifyExcuting,NSNumber *changePasswordExcuting) {
                              return @(usrInfoExcuting.boolValue || varifyExcuting.boolValue || changePasswordExcuting.boolValue);
                          }] distinctUntilChanged]
         subscribeNext:^(NSNumber *excuting) {
             @strongify(self);
             self.isExcuting = excuting.boolValue;
         }];
    }
    return self;
}

- (RACSignal *)updatePassword {
    return [[[MerchantClient payPasswordUpdate:self.phoneNumber varifyCode:self.varificationCode newPassword:self.password] doNext:^(id x) {
        DDLogVerbose(@"修改密码成功");
    }] doError:^(NSError *error) {
        self.error = error;
    }];
}
- (RACCommand *)changePasswordCommand {
    if (_changePasswordCommand == nil) {
        _changePasswordCommand = [self createCommandForSelector:@selector(updatePassword)];
    }
    return _changePasswordCommand;
}

-(RACSignal *)timeCountSignal{
    __block int count = 60;
    return [[[[RACSignal interval:1 onScheduler:[RACScheduler scheduler]] startWith:[NSDate date]]  take:count
        ]   map:^id (NSDate *value) {
        count--;
        return [NSString stringWithFormat:@"重新发送(%ds)",count];
    }];
}
- (RACSignal *)varifyCodeSignal {
    @weakify(self);
    return [[[MerchantClient varifyCodeSend:self.phoneNumber] doNext:^(id x) {
        @strongify(self);
        [[self.timeCountSignal deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSString *string) {
            self.sendCodeString = string;
        } completed:^{
            self.sendCodeString = nil;
        }];
    }] doError:^(NSError *error) {
        self.error = error;
    }];
}
- (RACCommand *)varifyCommand {
    if (_varifyCommand == nil) {
        _varifyCommand = [self createCommandForSelector:@selector(varifyCodeSignal)];
    }
    return _varifyCommand;
}

- (RACSignal *)usrInfoSignal {
    return [[[MerchantClient usrInfoSearch] doNext:^(id x) {
        UsersCustomerSearchResponse *response = (UsersCustomerSearchResponse *)x;
        UserCustomer *customer = [UserCustomer objectWithKeyValues:response.customer];
        self.phoneNumber = customer.mobile;
    }] doError:^(NSError *error) {
        self.error = error;
    }];
}
- (RACCommand *)usrInfoCommand {
    if (_usrInfoCommand == nil) {
        _usrInfoCommand = [self createCommandForSelector:@selector(usrInfoSignal)];
    }
    return _usrInfoCommand;
}

@end
