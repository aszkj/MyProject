//
//  APIManager+RACClient.m
//  jingGang
//
//  Created by ray on 15/10/28.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "APIManager+RACClient.h"

@implementation APIManager (RACClient)

- (RACSignal *)usersCustomerUpdate:(UsersCustomerUpdateRequest *)request {
    RACSubject* subject = [RACSubject subject];
    
    [self.vapiManager usersCustomerUpdate:request success:^(AFHTTPRequestOperation *operation, UsersCustomerUpdateResponse *response) {
        [self.class sendResponse:response withRACSubject:subject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:error];
    }];
     
    return subject;
}

- (RACSignal *)varifyCodeSend:(NSString *)phoneNumber {
    RACSubject* subject = [RACSubject subject];
    
    VerifyForgetcodeSendRequest *request = [[VerifyForgetcodeSendRequest alloc] init:GetToken];
    request.api_mobile = phoneNumber;
    [self.vapiManager verifyForgetcodeSend:request success:^(AFHTTPRequestOperation *operation, VerifyForgetcodeSendResponse *response) {
        [self.class sendResponse:response withRACSubject:subject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:error];
    }];
    return subject;
}

- (RACSignal *)usrInfoSearch {
    RACSubject* subject = [RACSubject subject];
    
    UsersCustomerSearchRequest *request = [[UsersCustomerSearchRequest alloc] init:GetToken];
    [self.vapiManager usersCustomerSearch:request success:^(AFHTTPRequestOperation *operation, UsersCustomerSearchResponse *response) {
        [self.class sendResponse:response withRACSubject:subject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:error];
    }];
    return subject;
}


- (RACSignal *)payPasswordUpdate:(NSString *)phoneNumber varifyCode:(NSString *)varifyCode newPassword:(NSString *)newPassword
{
    RACSubject* subject = [RACSubject subject];
    
    UsersPayPasswordUpdateRequest *request = [[UsersPayPasswordUpdateRequest alloc] init:GetToken];
    request.api_mobile = phoneNumber;
    request.api_code = varifyCode;
    request.api_password = newPassword;
    [self.vapiManager usersPayPasswordUpdate:request success:^(AFHTTPRequestOperation *operation, UsersPayPasswordUpdateResponse *response) {
        [self.class sendResponse:response withRACSubject:subject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:error];
    }];
    return subject;
}

- (RACSignal *)RACUpdatePassword:(NSString *)newPassword oldPassword:(NSString *)oldPassword {
    RACSubject *subject = [RACSubject subject];
    [self updatePassword:newPassword oldPassword:oldPassword successBlk:^(NSArray *responseData) {
        [subject sendNext:responseData];
        [subject sendCompleted];
    } failBlk:^(NSError *error) {
        [subject sendError:error];
    }];
    return subject;
}

- (RACSignal *)RACReportCheckList:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum {
    RACSubject *subject = [RACSubject subject];
    [self reportCheckList:pageSize pageNum:pageNum successBlk:^(NSArray *responseData) {
        [subject sendNext:responseData];
        [subject sendCompleted];
    } failBlk:^(NSError *error) {
        [subject sendError:error];
    }];
    return subject;
}

- (RACSignal *)RACGetDefaultAddress {
    RACSubject *subject = [RACSubject subject];
    [self getDefaultAddressSuccessBlk:^(NSArray *responseData) {
        [subject sendNext:responseData];
        [subject sendCompleted];
    } failBlk:^(NSError *error) {
        [subject sendError:error];
    }];
    return subject;
}

- (RACSignal *)RACCreateIntegralOrder:(NSString *)goodsJson
                            addressId:(NSNumber *)addressId igoMsg:(NSString *)message
{
    RACSubject *subject = [RACSubject subject];
    [self createIntegralOrder:goodsJson addressId:addressId igoMsg:message successBlk:^(NSArray *responseData) {
        [subject sendNext:responseData];
        [subject sendCompleted];
    } failBlk:^(NSError *error) {
        [subject sendError:error];
    }];
    return subject;
}

- (RACSignal *)RACGetIntegralOrderDetail:(NSNumber *)orderId {
    RACSubject *subject = [RACSubject subject];
    [self getIntegralOrderDetail:orderId successBlk:^(NSArray *responseData) {
        [subject sendNext:responseData];
        [subject sendCompleted];
    } failBlk:^(NSError *error) {
        [subject sendError:error];
    }];
    return subject;
}

- (RACSignal *)RACGetUsersIntegral {
    RACSubject *subject = [RACSubject subject];
    [self getUsersIntegralsuccessBlk:^(NSArray *responseData) {
        [subject sendNext:responseData];
        [subject sendCompleted];
    } failBlk:^(NSError *error) {
        [subject sendError:error];
    }];
    return subject;
}

- (RACSignal *)RACIntegralComputeOrder:(NSString *)goodsJson
                             addressId:(NSNumber *)addressId {
    RACSubject *subject = [RACSubject subject];
    [self integralComputeOrder:goodsJson addressId:addressId successBlk:^(NSArray *responseData) {
        [subject sendNext:responseData];
        [subject sendCompleted];
    } failBlk:^(NSError *error) {
        [subject sendError:error];
    }];
    return subject;
}

- (RACSignal *)usersFeedBack:(NSNumber *)source content:(NSString *)content {
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
