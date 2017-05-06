//
//  UserInfoViewModel.m
//  jingGang
//
//  Created by ray on 15/11/24.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "UserInfoViewModel.h"

@implementation MyUserCustomer
@synthesize sexStr = _sexStr, heightStr = _heightStr, weightStr = _weightStr;

- (NSString *)heightStr {
    return _heightStr = self.height.stringValue;
}

- (void)setHeightStr:(NSString *)heightStr {
//    if ([Util isPureFloat:heightStr]) {
        self.height = @(heightStr.integerValue);
//    }
}

- (NSString *)weightStr {
    return _weightStr = self.weight.stringValue;
}

- (void)setWeightStr:(NSString *)weightStr {
//    if ([Util isPureFloat:weightStr]) {
        self.weight = @(weightStr.doubleValue);
//    }
}

- (NSString *)sexStr {
    if (self.sex.integerValue == 1) {
        _sexStr = @"男";
    } else if (self.sex.integerValue == 2) {
        _sexStr = @"女";
    } else {
        _sexStr = @"";
    }
    return _sexStr;
}

- (void)setSexStr:(NSString *)sexStr {
    if ([sexStr isEqualToString:@"男"]) {
        _sexStr = sexStr;
        self.sex = @(1);
    } else if ([sexStr isEqualToString:@"女"]) {
        _sexStr = sexStr;
        self.sex = @(2);
    }
}

@end

@interface UserInfoViewModel ()

@property (nonatomic) NSString *sexString;

@end

@implementation UserInfoViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        @weakify(self);
        [[[RACSignal combineLatest:@[
                                     self.updateUserInfoCommand.executing,
                                     self.getUserInfoCommand.executing
                                     ]
                            reduce:^(NSNumber *usrInfoExcuting,NSNumber *changePasswordExcuting) {
                                return @(usrInfoExcuting.boolValue || changePasswordExcuting.boolValue);
                            }] distinctUntilChanged]
         subscribeNext:^(NSNumber *excuting) {
             @strongify(self);
             self.isExcuting = excuting.boolValue;
         }];
    }
    return self;
}

- (UsersCustomerUpdateRequest *)getrequest {
    UsersCustomerUpdateRequest *request = [[UsersCustomerUpdateRequest alloc] init:GetToken];
    request.api_nickname = self.userInfo.nickName;
    request.api_name = self.userInfo.name;
    request.api_height = self.userInfo.height;
    request.api_weight = self.userInfo.weight;
    request.api_sex = self.userInfo.sex;
    request.api_birthDate = self.userInfo.birthdate;
    request.api_email = self.userInfo.email;
    request.api_allergHistory = self.userInfo.allergicHistory;
    request.api_transGenetic = self.userInfo.transGenetic;
    request.api_transHistory = self.userInfo.transHistory;
    request.api_blood = self.userInfo.blood;

    return request;
}

- (RACSignal *)checkSignal {
    @weakify(self)
    return [[[[[RACObserve(self.userInfo, nickName) flattenMap:^RACStream *(NSString *value)
                {
                    @strongify(self)
                    if (value != nil && value.length > 0) {
                        return RACObserve(self.userInfo, name);
                    } else {
                        return [RACSignal error:[self createError:@"请填写您的昵称"]];
                    }
                }] flattenMap:^RACStream *(NSString *value) {
                    @strongify(self)
//                    if (value != nil && value.length > 0) {
                        return RACObserve(self.userInfo, heightStr);
//                    } else {
//                        return [RACSignal error:[self createError:@"请填写您的姓名"]];
//                    }
                }] flattenMap:^RACStream *(NSString *value) {
                    @strongify(self)
//                    if (value != nil && value.length > 0 && value.integerValue >= 99
//                        && value.integerValue <= 240 ) {
//                        return RACObserve(self.userInfo, weightStr);
//                    } else {
//                        return [RACSignal error:[self createError:@"请正确填写您的身高：99-240cm"]];
//                    }
                    if (value != nil && value.length > 0 && value.integerValue > 0 &&(value.integerValue < 99
                        || value.integerValue > 240) ) {
                        return [RACSignal error:[self createError:@"请正确填写您的身高：99-240cm"]];
                    }
                    return RACObserve(self.userInfo, weightStr);

                }] flattenMap:^RACStream *(NSString *value) {
                    @strongify(self)
//                    if (value != nil && value.length > 0 && value.integerValue >= 40
//                        && value.integerValue <= 99) {
//                        return RACObserve(self.userInfo, email);
//                    } else {
//                        return [RACSignal error:[self createError:@"请正确填写您的体重：40-99kg"]];
//                    }
                    if (value != nil && value.length > 0 && (value.integerValue < 20
                        || value.integerValue > 199)) {
                        return [RACSignal error:[self createError:@"请正确填写您的体重：20-199kg"]];
                    }
                    return RACObserve(self.userInfo, email);

                }] flattenMap:^RACStream *(NSString *value) {
                    @strongify(self)
//                    if ((value != nil && [Util isValidateEmail:value]) || [value isEqualToString:@""]) {
//                        [self.updateUserInfoCommand execute:nil];
//                        return [RACSignal empty];
//                    } else {
//                        return [RACSignal error:[self createError:@"请正确填写您的邮箱"]];
//                    }
                    if ((value != nil && ![Util isValidateEmail:value]) && ![value isEqualToString:@""]) {
                        return [RACSignal error:[self createError:@"请正确填写您的邮箱"]];
                    } else {
                    }
                    
                    
                    [self.updateUserInfoCommand execute:nil];
                    return [RACSignal empty];

                }];
}

- (RACCommand *)changeActionCommand {
//    if (_changeActionCommand == nil) {
        @weakify(self)
        _changeActionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [self checkSignal];
        }];
//    }
    return _changeActionCommand;
}

- (RACCommand *)updateUserInfoCommand {
    if (_updateUserInfoCommand == nil) {
        _updateUserInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[[self.client usersCustomerUpdate:[self getrequest]] doNext:^(id x) {
                
            }] doError:^(NSError *error) {
                self.error = error;
            }];
        }];
    }
    return _updateUserInfoCommand;
}

- (RACCommand *)getUserInfoCommand {
    if (_getUserInfoCommand == nil) {
        _getUserInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[[self.client usrInfoSearch] doNext:^(id x) {
                UsersCustomerSearchResponse *response = (UsersCustomerSearchResponse *)x;
                self.userInfo = [MyUserCustomer objectWithKeyValues:response.customer];

            }] doError:^(NSError *error) {
                self.error = error;
            }];
        }];
    }
    return _getUserInfoCommand;
}

@end
