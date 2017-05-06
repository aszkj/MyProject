//
//  OperatorClient.m
//  Operator_JingGang
//
//  Created by ray on 15/9/18.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "OperatorClient.h"

@implementation OperatorClient

- (id)init {
    self = [super init];
    if (self) {
        
        _dataCenter.delegate = self;
    }
    
    return self;    
}

- (RACSignal *)operatorProfitListRequestSize:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum
{
    RACSubject *subject = [RACSubject subject];
    XKO_EarningDetailRequestInfo *earning = [[XKO_EarningDetailRequestInfo alloc] init];
    earning.api_pageNum = pageNum;
    earning.api_pageSize = pageSize;
    [self.dataCenter requestOperatorProfitListFromModel:earning successBlk:^(NSArray *responseData) {
        [subject sendNext:responseData];
        [subject sendCompleted];
    } failBlk:^(NSError *error) {
        [subject sendError:error];
    }];
    
    return subject;
}

- (RACSignal *)operatorCashmoneyDetailsRequestSize:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum
{
    RACSubject *subject = [RACSubject subject];
    XKO_TakeDetailRequestInfo *takeDetailList = [[XKO_TakeDetailRequestInfo alloc] init];
    takeDetailList.api_pageSize = pageSize;
    takeDetailList.api_pageNum = pageNum;
    [self.dataCenter requestOperatorCashmoneyDetailsFromModel:takeDetailList successBlk:^(NSArray *responseData) {
        [subject sendNext:responseData];
        [subject sendCompleted];
    } failBlk:^(NSError *error) {
        [subject sendError:error];
    }];
    return subject;
}

- (RACSignal *)operatorMoneyCashRequestMoney:(NSNumber *)money password:(NSString *)password
{
    RACSubject *subject = [RACSubject subject];
    XKO_TakeMoneyRequestInfo *takeMoney = [[XKO_TakeMoneyRequestInfo alloc] init];
    takeMoney.api_money = money;
    takeMoney.api_password = password;
    [self.dataCenter requestOperatorMoneyCashFromModel:takeMoney successBlk:^(NSArray *responseData) {
        [subject sendNext:responseData];
        [subject sendCompleted];
    } failBlk:^(NSError *error) {
        [subject sendError:error];
    }];
    return subject;
}

- (RACSignal *)operatorInfoRequest
{
    RACSubject *subject = [RACSubject subject];
    XKO_BaseInfoRequestInfo *baseInfo = [[XKO_BaseInfoRequestInfo alloc] init];
    [self.dataCenter requestOperatorInfoFromModel:baseInfo successBlk:^(NSArray *responseData) {
        [subject sendNext:responseData];
        [subject sendCompleted];
    } failBlk:^(NSError *error) {
        [subject sendError:error];
    }];
    return subject;
}

- (RACSignal *)operatorMemberListRequestSize:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum
{
    RACSubject *subject = [RACSubject subject];
    XKO_MembersManagerRequestInfo *member = [[XKO_MembersManagerRequestInfo alloc] init];
    member.api_pageNum = pageNum;
    member.api_pageSize = pageSize;
    [self.dataCenter requestOperatorMemberListFromModel:member successBlk:^(NSArray *responseData) {
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
    request.api_userType = usrType;
    [_api groupMoneyCash:request success:^(AFHTTPRequestOperation *operation, GroupMoneyCashResponse *response) {
        
        [self.class sendResponse:response withRACSubject:subject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:error];
        
    }];
    
    return subject;
}

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

- (XKO_HttpRequestHelper *)dataCenter {
    if (!_dataCenter) {
        _dataCenter = [[XKO_HttpRequestHelper alloc] init];
    }
    return _dataCenter;
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

#pragma mark - DataCenterDelegate

// 读取数据成功
- (void)loadingFinishedWithDataArray:(NSArray *)dataArray methordName:(NSString *)methordName {
    
}

// 读取数据失败
- (void)loadingFailedWithErrorString:(NSError *)error methordName:(NSString *)methordName {

}

@end
