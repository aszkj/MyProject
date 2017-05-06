//
//  HomePageClient.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/12.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "MerchantClient.h"

@implementation MerchantClient

+ (RACSignal *)getBankInfo:(NSInteger)type {
    RACSubject* subject = [RACSubject subject];
    
    VApiManager *_api = [[VApiManager alloc] init];
    UsersBankInfoGetRequest *request = [[UsersBankInfoGetRequest alloc] init:GetToken];
    request.api_type = @(type);
    [_api usersBankInfoGet:request success:^(AFHTTPRequestOperation *operation, UsersBankInfoGetResponse *response) {
        [self.class sendResponse:response withRACSubject:subject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:error];
    }];
    return subject;
}


+ (RACSignal *)varifyCodeSend:(NSString *)phoneNumber {
    RACSubject* subject = [RACSubject subject];
    
    VApiManager *_api = [[VApiManager alloc] init];
    VerifyForgetcodeSendRequest *request = [[VerifyForgetcodeSendRequest alloc] init:GetToken];
    request.api_mobile = phoneNumber;
    [_api verifyForgetcodeSend:request success:^(AFHTTPRequestOperation *operation, VerifyForgetcodeSendResponse *response) {
        [self.class sendResponse:response withRACSubject:subject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:error];
    }];
    return subject;
}

+ (RACSignal *)payPasswordUpdate:(NSString *)phoneNumber varifyCode:(NSString *)varifyCode newPassword:(NSString *)newPassword
{
    RACSubject* subject = [RACSubject subject];
    
    VApiManager *_api = [[VApiManager alloc] init];
    UsersPayPasswordUpdateRequest *request = [[UsersPayPasswordUpdateRequest alloc] init:GetToken];
    request.api_mobile = phoneNumber;
    request.api_code = varifyCode;
    request.api_password = newPassword;
    [_api usersPayPasswordUpdate:request success:^(AFHTTPRequestOperation *operation, UsersPayPasswordUpdateResponse *response) {
        [self.class sendResponse:response withRACSubject:subject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:error];
    }];
    return subject;
}

+ (RACSignal *)usrInfoSearch {
    RACSubject* subject = [RACSubject subject];
    
    VApiManager *_api = [[VApiManager alloc] init];
    UsersCustomerSearchRequest *request = [[UsersCustomerSearchRequest alloc] init:GetToken];
    [_api usersCustomerSearch:request success:^(AFHTTPRequestOperation *operation, UsersCustomerSearchResponse *response) {
        [self.class sendResponse:response withRACSubject:subject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:error];
    }];
    return subject;
}

+ (RACSignal *)queryStoreStatus {
    RACSubject* subject = [RACSubject subject];
    
    VApiManager *_api = [[VApiManager alloc] init];
    GroupQueryStoreStatusRequest *request = [[GroupQueryStoreStatusRequest alloc] init:GetToken];
    [_api groupQueryStoreStatus:request success:^(AFHTTPRequestOperation *operation, GroupQueryStoreStatusResponse *response) {

        [self.class sendResponse:response withRACSubject:subject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:error];
    }];
    return subject;
}

+ (RACSignal *)merchantShareDetail:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum {
    RACSubject* subject = [RACSubject subject];
    
    VApiManager *_api = [[VApiManager alloc] init];
    GroupShareDetailsRequest *request = [[GroupShareDetailsRequest alloc] init:GetToken];
    request.api_pageNum = pageNum;
    request.api_pageSize = pageSize;
    [_api groupShareDetails:request success:^(AFHTTPRequestOperation *operation, GroupShareDetailsResponse *response) {

        [self.class sendResponse:response withRACSubject:subject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:error];
    }];
    
    return subject;
}

+ (RACSignal *)takeListSignal:(NSNumber *)opType pageSize:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum {
    RACSubject* subject = [RACSubject subject];

    VApiManager *_api = [[VApiManager alloc] init];
    GroupPredepositListRequest *request = [[GroupPredepositListRequest alloc] init:GetToken];
    request.api_pageNum = pageNum;
    request.api_pageSize = pageSize;
    request.api_opType = opType;
    [_api groupPredepositList:request success:^(AFHTTPRequestOperation *operation, GroupPredepositListResponse *response) {

        [self.class sendResponse:response withRACSubject:subject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:error];
    }];

    return subject;
}

+ (RACSignal *)takeMoneySignalSignal:(NSNumber *)cashAmount payment:(NSString *)cashPayment
                            userName:(NSString *)cashUserName bank:(NSString *)cashBank
                             account:(NSString *)cashAccount password:(NSString *)password
                                info:(NSString *)cashInfo usrType:(NSNumber *)usrType
{
    RACSubject* subject = [RACSubject subject];
    
    VApiManager *_api = [[VApiManager alloc] init];
    GroupMoneyCashRequest *request = [[GroupMoneyCashRequest alloc] init:GetToken];
    request.api_cashBank = cashBank;
    request.api_cashAmount = cashAmount;
    request.api_cashPayment = cashPayment;
    request.api_cashUserName = cashUserName;
    request.api_cashPassword = password;
    request.api_cashInfo = cashInfo;
    request.api_cashAccount = cashAccount;
    request.api_userType = usrType.copy;
    [_api groupMoneyCash:request success:^(AFHTTPRequestOperation *operation, GroupMoneyCashResponse *response) {
        
        [self.class sendResponse:response withRACSubject:subject]; 
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:error];
    
    }];
    
    return subject;
}

+ (RACSignal *)yunbiInfoSignal {
    RACSubject* subject = [RACSubject subject];
    
    VApiManager *_api = [[VApiManager alloc] init];
    GroupAvailableBalanceGetRequest *request = [[GroupAvailableBalanceGetRequest alloc] init:GetToken];
    [_api groupAvailableBalanceGet:request success:^(AFHTTPRequestOperation *operation, GroupAvailableBalanceGetResponse *response) {

        [self.class sendResponse:response withRACSubject:subject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:error];
    }];
    
    return subject;
}

+ (RACSignal *)merchantInfoSignal {
    RACSubject* subject = [RACSubject subject];

    VApiManager *_api = [[VApiManager alloc] init];
    GroupMerchantInfoRequest *request = [[GroupMerchantInfoRequest alloc] init:GetToken];
    [_api groupMerchantInfo:request success:^(AFHTTPRequestOperation *operation, GroupMerchantInfoResponse *response) {
        
        [self.class sendResponse:response withRACSubject:subject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:error];
    }];
    
    return subject;
}

+ (RACSignal *)usersFeedBack:(NSNumber *)source content:(NSString *)content {
    RACSubject *subject = [RACSubject subject];
    UsersFeedBackRequest *request = [[UsersFeedBackRequest alloc] init:GetToken];
    request.api_source = source;
    request.api_content = content;
    
    VApiManager *_vapi = [[VApiManager alloc] init];
    [_vapi usersFeedBack:request success:^(AFHTTPRequestOperation *operation, UsersFeedBackResponse *response) {
        [self.class sendResponse:response withRACSubject:subject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:error];
    }];
    return subject;
}

+ (void)sendResponse:(AbstractResponse *)response withRACSubject:(RACSubject *)subject {
    if ([self.class checkResponse:response] != nil) {
        [subject sendError:[self.class checkResponse:response]];
        return;
    }
    [subject sendNext:response];
    [subject sendCompleted];
}

+ (NSError *)checkResponse:(AbstractResponse *)response {
    NSError *error = nil;
    if (response.errorCode.integerValue > 0) {
        error = [[NSError alloc] initWithDomain:response.subCode code:response.errorCode.integerValue userInfo:[NSDictionary dictionaryWithObject:response.subMsg                                                                      forKey:NSLocalizedDescriptionKey]];
    }
    return error;
}

@end
