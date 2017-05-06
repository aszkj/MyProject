//
//  XKO_HttpRequestHelper.m
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_HttpRequestHelper.h"
#import "XKO_TakeMoneyResponseInfo.h"
#import "XKO_BaseInfoResponseInfo.h"
#import "XKO_MembersManagerResponseInfo.h"
#import "XKO_TakeDetailResponseInfo.h"
#import "XKO_EarningDetailResponseInfo.h"
#import "XKO_OperatorInvitationCodeResponseInfo.h"

@interface XKO_HttpRequestHelper ()

@property(nonatomic, strong) VApiManager *vapManager;
@property(nonatomic, strong) NSNumberFormatter *numberFormatter;
@property(nonatomic, strong) NSString *methordName;

@end

@implementation XKO_HttpRequestHelper

#pragma mark - 属性

- (VApiManager *)vapManager
{
    if (!_vapManager) {
        _vapManager = [[VApiManager alloc] init];
    }
    return _vapManager;
}

- (NSNumberFormatter *)numberFormatter
{
    if (!_numberFormatter) {
        _numberFormatter = [[NSNumberFormatter alloc] init];
    }
    return _numberFormatter;
}

#pragma mark - private methord
#pragma mark - json转model

-(NSArray *)JGObjectArrWihtKeyValuesArr:(AbstractResponse *)abstractResponse{
    
    NSArray *responseArray = [[NSArray alloc] init];
    if ([abstractResponse isMemberOfClass:[GroupQueryGoodsListResponse class]]) {
        GroupQueryGoodsListResponse *response = (GroupQueryGoodsListResponse *)abstractResponse;
        responseArray = [GroupGoods JGObjectArrWihtKeyValuesArr:response.groupGoodsBOs];
    }
    
    return responseArray;
}

/**
 *  检查服务器是否返回了错误信息
 *
 *  @param response 服务器返回信息
 *
 *  @return Yes:没有错误信息；No:有错误信息；
 */
- (BOOL)CheckErrorCode:(AbstractResponse *)response {
    
    if (IsEmpty(response.errorCode)) {
            return YES;
        
    } else {
        
        NSError *error = [[NSError alloc] initWithDomain:@"" code:[response.errorCode integerValue] userInfo:[NSDictionary dictionaryWithObject:response.subMsg                                                                      forKey:NSLocalizedDescriptionKey]];
        
        [self loadingFailed:error];
    }
    
    return NO;
}

- (void)requestDataFromRequest:(AbstractRequest *)request {
    
    if ([request isMemberOfClass:[GroupQueryGoodsListRequest class]]) {
        GroupQueryGoodsListRequest *newRequest = (GroupQueryGoodsListRequest *)request;
        [self.vapManager groupQueryGoodsList:(newRequest) success:^(AFHTTPRequestOperation *operation, GroupQueryGoodsListResponse *response) {
            
            [self loadingFinished:[self JGObjectArrWihtKeyValuesArr:response]];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [self loadingFailed:error];
        }];
    }
}

- (void)cancelRequest
{
    NSLog(@"cancel request");
    [self.vapManager.operationQueue cancelAllOperations];
}

- (void)loadingFinished:(NSArray *)responseArray
{
    if (_finishBlk) {
        _finishBlk(responseArray);
        _finishBlk = nil;
        return;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(loadingFinishedWithDataArray:methordName:)]) {
        [_delegate loadingFinishedWithDataArray:responseArray methordName:_methordName];
    }
}

- (void)loadingFailed:(NSError *)error
{
    if (_failBlk) {
        _failBlk(error);
        _failBlk = nil;
        return;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(loadingFailedWithErrorString:methordName:)]) {
        [_delegate loadingFailedWithErrorString:error methordName:_methordName];
    }
}

#pragma mark - 接口请求

//营运商基本信息(从服务器读取数据)
- (void)requestOperatorInfoFromModel:(XKO_BaseInfoRequestInfo *)requestModel {
    
    OperatorInfoGetRequest *request = [[OperatorInfoGetRequest alloc] init:GetToken];
    self.methordName = requestModel.requestMethordName;

    [self.vapManager operatorInfoGet:request success:^(AFHTTPRequestOperation *operation, OperatorInfoGetResponse *response) {
        
        if ([self CheckErrorCode:response]) {
            [self loadingFinished:[XKO_BaseInfoResponseInfo JGObjectArrWihtKeyValuesArr:[NSArray arrayWithObject:response.operatorInfo]]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self loadingFailed:error];
    }];
}

//营运商基本信息(从服务器读取数据(block方式))
- (void)requestOperatorInfoFromModel:(XKO_BaseInfoRequestInfo *)requestModel successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk {
    
    [self requestOperatorInfoFromModel:requestModel];
    self.finishBlk = finishBlk;
    self.failBlk = failBlk;
}

//营运商隶属会员(从服务器读取数据)
- (void)requestOperatorMemberListFromModel:(XKO_MembersManagerRequestInfo *)requestModel {
    
    OperatorMemberListRequest *request = [[OperatorMemberListRequest alloc] init:GetToken];
    request.api_pageSize = requestModel.api_pageSize;
    request.api_pageNum = requestModel.api_pageNum;
    self.methordName = requestModel.requestMethordName;

    
    [self.vapManager operatorMemberList:request success:^(AFHTTPRequestOperation *operation, OperatorMemberListResponse *response) {
        
        if ([self CheckErrorCode:response]) {
            [self loadingFinished:[XKO_MembersManagerResponseInfo JGObjectArrWihtKeyValuesArr:response.memberList]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self loadingFailed:error];
    }];
}

//营运商隶属会员(从服务器读取数据(block方式))
- (void)requestOperatorMemberListFromModel:(XKO_MembersManagerRequestInfo *)requestModel successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk {
    
    [self requestOperatorMemberListFromModel:requestModel];
    self.finishBlk = finishBlk;
    self.failBlk = failBlk;
}

//营运商提现(从服务器读取数据)
- (void)requestOperatorMoneyCashFromModel:(XKO_TakeMoneyRequestInfo *)requestModel {
    
    OperatorMoneyCashRequest *request = [[OperatorMoneyCashRequest alloc] init:GetToken];
    self.methordName = requestModel.requestMethordName;
    request.api_money = requestModel.api_money;
    request.api_password = requestModel.api_password;
    
    [self.vapManager operatorMoneyCash:request success:^(AFHTTPRequestOperation *operation, OperatorMoneyCashResponse *response) {
        
        if ([self CheckErrorCode:response]) {
            XKO_TakeMoneyResponseInfo *takeMoneyInfo = [[XKO_TakeMoneyResponseInfo alloc] init];
            takeMoneyInfo.isSuccessed = YES;
            [self loadingFinished:[NSArray arrayWithObject:takeMoneyInfo]];
        }
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self loadingFailed:error];
    }];
}

//营运商提现(从服务器读取数据(block方式))
- (void)requestOperatorMoneyCashFromModel:(XKO_TakeMoneyRequestInfo *)requestModel successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk {
    
    [self requestOperatorMoneyCashFromModel:requestModel];
    self.finishBlk = finishBlk;
    self.failBlk = failBlk;
}

//营运商提现明细(从服务器读取数据)
- (void)requestOperatorCashmoneyDetailsFromModel:(XKO_TakeDetailRequestInfo *)requestModel {
    
    OperatorCashMoneyDetailsRequest *request = [[OperatorCashMoneyDetailsRequest alloc] init:GetToken];
    request.api_pageNum = requestModel.api_pageNum;
    request.api_pageSize = requestModel.api_pageSize;
    self.methordName = requestModel.requestMethordName;

    [self.vapManager operatorCashMoneyDetails:request success:^(AFHTTPRequestOperation *operation, OperatorCashMoneyDetailsResponse *response) {
        
        if ([self CheckErrorCode:response]) {
            [self loadingFinished:[XKO_TakeDetailResponseInfo JGObjectArrWihtKeyValuesArr:response.cashMoneyDetailsBOs]];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self loadingFailed:error];
    }];
}

//营运商提现明细(从服务器读取数据(block方式))
- (void)requestOperatorCashmoneyDetailsFromModel:(XKO_TakeDetailRequestInfo *)requestModel successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk {
    
    [self requestOperatorCashmoneyDetailsFromModel:requestModel];
    self.finishBlk = finishBlk;
    self.failBlk = failBlk;
}

//营运商收益明细(从服务器读取数据)
- (void)requestOperatorProfitListFromModel:(XKO_EarningDetailRequestInfo *)requestModel {
    
    OperatorProfitListRequest *request = [[OperatorProfitListRequest alloc] init:GetToken];
    request.api_pageSize = requestModel.api_pageSize;
    request.api_pageNum = requestModel.api_pageNum;
    self.methordName = requestModel.requestMethordName;

    [self.vapManager operatorProfitList:request success:^(AFHTTPRequestOperation *operation, OperatorProfitListResponse *response) {
        
        if ([self CheckErrorCode:response]) {
            [self loadingFinished:[XKO_EarningDetailResponseInfo JGObjectArrWihtKeyValuesArr:response.operatorList]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self loadingFailed:error];
    }];
}

//营运商收益明细(从服务器读取数据(block方式))
- (void)requestOperatorProfitListFromModel:(XKO_EarningDetailRequestInfo *)requestModel successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk {
    
    [self requestOperatorProfitListFromModel:requestModel];
    self.finishBlk = finishBlk;
    self.failBlk = failBlk;
}
-(void)requestOperatorExpectProfitListFromModel:(XKO_EarningDetailRequestInfo *)requestModel successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk
{
    OperatorExpectProfitListRequest *request = [[OperatorExpectProfitListRequest alloc] init:GetToken];
    request.api_pageSize = requestModel.api_pageSize;
    request.api_pageNum = requestModel.api_pageNum;
    self.methordName = requestModel.requestMethordName;
    
    [self.vapManager operatorExpectProfitList:request success:^(AFHTTPRequestOperation *operation, OperatorExpectProfitListResponse *response) {
        
        if ([self CheckErrorCode:response]) {
            [self loadingFinished:[NSArray arrayWithObject:response]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self loadingFailed:error];
    }];
    self.finishBlk = finishBlk;
    self.failBlk = failBlk;
}

/**
 *  营运商邀请码(从服务器读取数据)
 *
 *  @param requestModel 请求信息
 */
- (void)requestOperatorInvitationCodeFromModel:(XKO_OperatorInvitationCodeRequestInfo *)requestModel {
    
    OperatorInvitationCodeGetRequest *request = [[OperatorInvitationCodeGetRequest alloc] init:GetToken];
    self.methordName = requestModel.requestMethordName;
    
    [self.vapManager operatorInvitationCodeGet:request success:^(AFHTTPRequestOperation *operation, OperatorInvitationCodeGetResponse *response) {
        
        if ([self CheckErrorCode:response]) {
            XKO_OperatorInvitationCodeResponseInfo * responseInfo = [[XKO_OperatorInvitationCodeResponseInfo alloc] init];
            responseInfo.invitationCode = response.invitationCode;
            
            [self loadingFinished:[NSArray arrayWithObject:responseInfo]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self loadingFailed:error];
        
    }];
}

/**
 *  营运商邀请码(从服务器读取数据(block方式))
 *
 *  @param requestModel 请求信息
 *  @param finishBlk    成功block
 *  @param failBlk      失败block
 */
- (void)requestOperatorInvitationCodeFromModel:(XKO_OperatorInvitationCodeRequestInfo *)requestModel successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk {
    
    [self requestOperatorInvitationCodeFromModel:requestModel];
    self.finishBlk = finishBlk;
    self.failBlk = failBlk;
}

@end
