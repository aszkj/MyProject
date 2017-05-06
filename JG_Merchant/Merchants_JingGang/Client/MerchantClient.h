//
//  HomePageClient.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/12.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@interface MerchantClient : NSObject

@property (nonatomic) NSString *errorDescription;

/**
 *  发送忘记密码验证码
 *
 *  @param phoneNumber 手机密码
 */
+ (RACSignal *)varifyCodeSend:(NSString *)phoneNumber;
/**
 *  修改云币密码
 *
 *  @param phoneNumber 手机号
 *  @param varifyCode  验证码
 *  @param newPassword 新密码
 */
+ (RACSignal *)payPasswordUpdate:(NSString *)phoneNumber varifyCode:(NSString *)varifyCode newPassword:(NSString *)newPassword;
/**
 *  获取用户信息
 */
+ (RACSignal *)usrInfoSearch;
/**
 *  获取银行信息
 *
 *  @param type 1商户 2运营商
 */
+ (RACSignal *)getBankInfo:(NSInteger)type;
+ (RACSignal *)queryStoreStatus;
+ (RACSignal *)merchantShareDetail:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum;
+ (RACSignal *)takeListSignal:(NSNumber *)opType pageSize:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum;
+ (RACSignal *)takeMoneySignalSignal:(NSNumber *)cashAmount payment:(NSString *)cashPayment
                            userName:(NSString *)cashUserName bank:(NSString *)cashBank
                             account:(NSString *)cashAccount password:(NSString *)password
                                info:(NSString *)cashInfo usrType:(NSNumber *)usrType;
+ (RACSignal *)yunbiInfoSignal;
+ (RACSignal *)merchantInfoSignal;
/**
 *  问题反馈
 *
 *  @param source  来源
 *  @param content 反馈内容
 *
 */
+ (RACSignal *)usersFeedBack:(NSNumber *)source content:(NSString *)content;

@end
