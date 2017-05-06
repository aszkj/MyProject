//
//  changeLoginViewModel.m
//  jingGang
//
//  Created by ray on 15/11/24.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "changeLoginViewModel.h"

@interface changeLoginViewModel ()


@end

@implementation changeLoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        @weakify(self)
        [[self.updatePasswordCommand executing] subscribeNext:^(NSNumber *x) {
            @strongify(self)
            self.isExcuting = [x boolValue];
        }];

    }
    return self;
}

- (NSError *)createError:(NSString *)message {
        return [[NSError alloc] initWithDomain:@"00" code:0 userInfo:[NSDictionary dictionaryWithObject:message                                                                      forKey:NSLocalizedDescriptionKey]];

}

- (RACSignal *)checkPassword {
    @weakify(self)
    self.errorMessage = nil;
    if (_checkPassword == nil) {
        _checkPassword = [[[[RACObserve(self, oldPassword) take:1] flattenMap:^RACStream *(NSString *value) {
            @strongify(self)
            BOOL check = value != nil && value.length > 0;
            if (!check && !self.errorMessage) {
                self.errorMessage = @"请填写原密码";
                return [RACSignal error:[self createError:self.errorMessage]];
            }
            return RACObserve(self, updatePassword);
        }] flattenMap:^RACStream *(NSString *value) {
            BOOL check = value != nil && value.length > 0;
            if (!check && !self.errorMessage) {
                self.errorMessage = @"请填写新密码";
                return [RACSignal error:[self createError:self.errorMessage]];
            }
            return RACObserve(self, confirmPassword);
        }]  flattenMap:^RACStream *(NSString *value) {
            BOOL check = value != nil && value.length > 0;
            if (!check && !self.errorMessage) {
                self.errorMessage = @"请再次输入新密码";
                return [RACSignal error:[self createError:self.errorMessage]];
            }
            if (![value isEqualToString:self.updatePassword] && !self.errorMessage) {
                self.errorMessage = @"两次密码不一致";
                return [RACSignal error:[self createError:self.errorMessage]];
            }
            return [RACSignal empty];
        }];
    }
    return _checkPassword;
}

- (RACCommand *)updatePasswordCommand {
    if (_updatePasswordCommand == nil) {
        @weakify(self)
        _updatePasswordCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[[self.client RACUpdatePassword:self.updatePassword oldPassword:self.oldPassword] doNext:^(id x) {
                
            }] doError:^(NSError *error) {
                @strongify(self)
                self.error = error;
            }];
        }];
    }
    return _updatePasswordCommand;
}

@end
