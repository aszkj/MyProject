//
//  APIManager+Helper.m
//  jingGang
//
//  Created by ray on 15/10/28.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "APIManager+Helper.h"
#import "NSObject+MJExtension.h"
#import "NSObject+MJProperty.h"
#import "MERHomePageEntity.h"

@implementation APIManager (Helper)

- (void)loadingFinished:(id)responseArray successBlk:(DataCenterBlock)finishBlk {
    if (finishBlk) {
        finishBlk(responseArray);
        return;
    }
    
    //    if (_delegate && [_delegate respondsToSelector:@selector(loadingFinishedWithDataArray:methordName:)]) {
    //        [_delegate loadingFinishedWithDataArray:responseArray methordName:_methordName];
    //    }
}

- (void)loadingFailed:(NSError *)error failBlk:(FailDataCenterBlock)failBlk
{
    if (failBlk) {
        failBlk(error);
        return;
    }
    
    //    if (_delegate && [_delegate respondsToSelector:@selector(loadingFailedWithErrorString:methordName:)]) {
    //        [_delegate loadingFailedWithErrorString:error methordName:_methordName];
    //    }
}
/**
 *  检查服务器是否返回了错误信息
 *
 *  @param response 服务器返回信息
 *
 *  @return Yes:没有错误信息；No:有错误信息；
 */
- (BOOL)CheckErrorCode:(AbstractResponse *)response failBlk:(FailDataCenterBlock)failBlk {
    
    if (IsEmpty(response.errorCode)) {
        return YES;
        
    } else {
        
        NSError *error = [[NSError alloc] initWithDomain:@"" code:[response.errorCode integerValue] userInfo:[NSDictionary dictionaryWithObject:response.subMsg                                                                      forKey:NSLocalizedDescriptionKey]];
        
        [self loadingFailed:error failBlk:failBlk];
    }
    
    return NO;
}
static inline BOOL IsEmpty(id thing) {
    
    return thing == nil || [thing isEqual:[NSNull null]]
    
    || ([thing respondsToSelector:@selector(length)]
        
        && [(NSData *)thing length] == 0)
    
    || ([thing respondsToSelector:@selector(count)]
        
        && [(NSArray *)thing count] == 0);
    
}

- (void)reportCheckList:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum
             successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk
{
    ReportCheckListRequest *request = ({
        ReportCheckListRequest *checkListRequest= [[ReportCheckListRequest alloc] init:GetToken];
        checkListRequest.api_pageNum = pageNum;
        checkListRequest.api_pageSize = pageSize;
        checkListRequest;
    });
    [self.vapiManager reportCheckList:request success:^(AFHTTPRequestOperation *operation, ReportCheckListResponse *response) {
        
        if ([self CheckErrorCode:response failBlk:failBlk]) {
            [self loadingFinished:[MERHomePageEntity JGObjectArrWihtKeyValuesArr:response.circle] successBlk:finishBlk];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self loadingFailed:error failBlk:failBlk];
    }];
}
- (void)reportCheckList:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum {
    [self reportCheckList:pageNum pageNum:pageNum successBlk:nil failBlk:nil];
    
}

- (void)getDefaultAddressSuccessBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk {
    ShopUserAddressAllRequest *request = [[ShopUserAddressAllRequest alloc] init:GetToken];
    request.api_def = [NSNumber numberWithBool:YES];    //默认收货地址
    [self.vapiManager shopUserAddressAll:request success:^(AFHTTPRequestOperation *operation, ShopUserAddressAllResponse *response) {
       
        if ([self CheckErrorCode:response failBlk:failBlk]) {
            if (response.defaultAddress != nil) {
                [self loadingFinished:[ShopUserAddress JGObjectArrWihtKeyValuesArr:@[response.defaultAddress]] successBlk:finishBlk];
            } else {
                [self loadingFinished:nil successBlk:finishBlk];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self loadingFailed:error failBlk:failBlk];
    }];
    
}

- (void)createIntegralOrder:(NSString *)goodsJson
                  addressId:(NSNumber *)addressId igoMsg:(NSString *)message
                 successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk
{
    IntegralSaveOrderRequest *resquest = ({
        IntegralSaveOrderRequest *integralOrderRequest= [[IntegralSaveOrderRequest alloc] init:GetToken];
        integralOrderRequest.api_goodsJson = goodsJson;
        integralOrderRequest.api_addressId = addressId;
        integralOrderRequest.api_igoMsg = message;
        integralOrderRequest;
    });
    [self.vapiManager integralSaveOrder:resquest success:^(AFHTTPRequestOperation *operation, IntegralSaveOrderResponse *response) {
        
        if ([self CheckErrorCode:response failBlk:failBlk]) {
            [self loadingFinished:[OrderBO JGObjectArrWihtKeyValuesArr:@[response.orderBO]] successBlk:finishBlk];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self loadingFailed:error failBlk:failBlk];
    }];
}

- (void)getIntegralOrderDetail:(NSNumber *)orderId
                    successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk {
    IntegralOrderDetailsRequest *request = ({
        IntegralOrderDetailsRequest *orderRequest= [[IntegralOrderDetailsRequest alloc] init:GetToken];
        orderRequest.api_id = orderId;
        orderRequest;
    });
    [self.vapiManager integralOrderDetails:request success:^(AFHTTPRequestOperation *operation, IntegralOrderDetailsResponse *response) {
        if ([self CheckErrorCode:response failBlk:failBlk]) {
            [IntegralOrderDetails setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"igoList" : [IGo class]
                         };
            }];
            [IGo setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"apiId":@"id"};
            }];
            [self loadingFinished:[IntegralOrderDetails JGObjectArrWihtKeyValuesArr:@[response.details]] successBlk:finishBlk];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self loadingFailed:error failBlk:failBlk];
    }];
}

- (void)getUsersIntegralsuccessBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk {
    UsersIntegralGetRequest *request = [[UsersIntegralGetRequest alloc] init:GetToken];
    [self.vapiManager usersIntegralGet:request success:^(AFHTTPRequestOperation *operation, UsersIntegralGetResponse *response) {
        if ([self CheckErrorCode:response failBlk:failBlk]) {
            [self loadingFinished:[UserIntegral JGObjectArrWihtKeyValuesArr:@[response.integral]] successBlk:finishBlk];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self loadingFailed:error failBlk:failBlk];
    }];
}

- (void)integralComputeOrder:(NSString *)goodsJson addressId:(NSNumber *)addressId                     successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk {
    IntegralComputeOrderRequest *request = [[IntegralComputeOrderRequest alloc] init:GetToken];
    request.api_addressId = addressId;
    request.api_goodsJson = goodsJson;
    [self.vapiManager integralComputeOrder:request success:^(AFHTTPRequestOperation *operation, IntegralComputeOrderResponse *response) {
        if ([self CheckErrorCode:response failBlk:failBlk]) {
            [self loadingFinished:[ComputeOrderBO JGObjectArrWihtKeyValuesArr:@[response.computeOrderBO]] successBlk:finishBlk];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self loadingFailed:error failBlk:failBlk];
    }];
}

- (void)updatePassword:(NSString *)newPassword oldPassword:(NSString *)oldPassword
            successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk {
    UsersPasswordUpdateRequest *request = [[UsersPasswordUpdateRequest alloc] init:GetToken];
    request.api_newPassword = newPassword;
    request.api_odlPassword = oldPassword;
    [self.vapiManager usersPasswordUpdate:request success:^(AFHTTPRequestOperation *operation, UsersPasswordUpdateResponse *response) {
        if ([self CheckErrorCode:response failBlk:failBlk]) {
            [self loadingFinished:response successBlk:finishBlk];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self loadingFailed:error failBlk:failBlk];
    }];
}


@end
