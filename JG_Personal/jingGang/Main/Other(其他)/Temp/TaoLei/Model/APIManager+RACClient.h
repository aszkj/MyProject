//
//  APIManager+RACClient.h
//  jingGang
//
//  Created by ray on 15/10/28.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "APIManager.h"
#import <ReactiveCocoa.h>
#import "APIManager+Helper.h"

@interface APIManager (RACClient)

- (RACSignal *)RACReportCheckList:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum;
- (RACSignal *)RACGetDefaultAddress;
- (RACSignal *)RACCreateIntegralOrder:(NSString *)goodsJson
                            addressId:(NSNumber *)addressId igoMsg:(NSString *)message;
- (RACSignal *)RACGetIntegralOrderDetail:(NSNumber *)orderId;
- (RACSignal *)RACGetUsersIntegral;
- (RACSignal *)RACIntegralComputeOrder:(NSString *)goodsJson
                             addressId:(NSNumber *)addressId;
- (RACSignal *)RACUpdatePassword:(NSString *)newPassword oldPassword:(NSString *)oldPassword;
- (RACSignal *)payPasswordUpdate:(NSString *)phoneNumber varifyCode:(NSString *)varifyCode newPassword:(NSString *)newPassword;
- (RACSignal *)usrInfoSearch;
- (RACSignal *)varifyCodeSend:(NSString *)phoneNumber;
- (RACSignal *)usersCustomerUpdate:(UsersCustomerUpdateRequest *)request;

/**
 *  问题反馈
 *
 *  @param source  来源
 *  @param content 反馈内容
 *
 */
- (RACSignal *)usersFeedBack:(NSNumber *)source content:(NSString *)content;
@end
