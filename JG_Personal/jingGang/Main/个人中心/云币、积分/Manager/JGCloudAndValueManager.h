//
//  JGCloudAndValueManager.h
//  jingGang
//
//  Created by dengxf on 16/1/11.
//  Copyright © 2016年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VApiManager.h"

/**
 *  提现方式 */
typedef NS_ENUM(NSUInteger, JGCashPayType) {
    /**
     *  银行卡提现 */
    CashPayBankType = 0,
    /**
     *  支付宝提现 */
    CashPayAliType
};
/**
 *  充值方式
 */
typedef NS_ENUM(NSUInteger, JGPayCloudValueType) {
    /**
     *  微信支付 */
    JGPayCloudValueWithWXType = 0,
    /**
     *  支付宝支付  */
    JGPayCloudValueWithAliType,
};

/**
 *  云币、提现管理类 */
@interface JGCloudAndValueManager : NSObject

/**
 *  查询默认银行 
 *  cloudPredepositCash 表单对象
 */
+ (void)inquiryCashDefaultsType:(void(^)(CloudForm *cloudPredepositCash))success fail:(void(^)())fail error:(void(^)(NSError *error))errorBlock;

/**
 *  查询当前用户登录手机号码 */
+ (void)inquiryUserCurrentLoginPhoneNumber:(void(^)(NSString *loginName))loginName error:(void(^)(NSError *error))errorBlock;


/**
 *  查询用户是否设置过支付密码
 */
+ (void)inquiryUserDidSetPayPasswordWithResult:(void(^)(BOOL result))result error:(void(^)(NSError *error))errorBlock;

/**
 *  设置支付码,给手机发送短信，获取验证码 */
+ (void)sendMsmToPhoneValidateWithPhoneNumber:(NSString *)phoneNumber success:(void(^)(NSString *msg))success fail:(void(^)(void))fail;

/**
 *  设置云币提现的支付密码
 *  @param password 支付密码 
    @param code     验证码
 */
+ (void)st_userCashPayPasswordWithPswd:(NSString *)password valiteCode:(NSString *)code success:(void(^)(CloudBuyerMoneyPasswordSaveResponse *response))success error:(void(^)(NSError *error))errorBlock;

/**
 *  验证用户当前输入的支付密码正确性 */
+ (void)validateUserCashPayPassword:(NSString *)password success:(void(^)(BOOL ret))success error:(void(^)(NSError *error))errorBlock;

/**
 *  调用提现接口
 *
 *  @param payment       提现方式    银行卡- chinabank   支付宝- alipay
 *  @param cashAmount    提现金额
 *  @param cashUserName  收款人姓名   银行卡- 持卡人姓名   支付宝- 支付宝账号姓名
 *  @param cashBank      收款银行        银行卡-卡行         支付宝- @""
 *  @param cashAccount   收款账号     银行卡-卡号         支付宝- 账号
 *  @param cashPassword  提现密码    提现密码
 *  @param cashInfo      提现备注        备注
 *  @param cashSubbranch 银行卡 - 支行   支付- @""
 *  @param cashId        云币提现id  有默认cashid 就传cashid 没有或重新新选择另外一个支付方式或银行就传空
 */
+ (void)callCashWithCashPayment:(JGCashPayType)payment
                     cashAmount:(CGFloat)cashAmount
                   cashUserName:(NSString *)cashUserName
                       cashBank:(NSString *)cashBank
                    cashAccount:(NSString *)cashAccount
                   cashPassword:(NSString *)cashPassword
                       cashInfo:(NSString *)cashInfo
                  cashSubbranch:(NSString *)cashSubbranch
                     needCashId:(BOOL)needCashId
                         cashId:(CGFloat)cashId
                        success:(void(^)(CloudBuyerCashSaveResponse *response))success
                           fail:(void(^)(NSString *failMsg))fail
                          error:(void(^)(NSError *error))errorBlock;


/** -------------------------充值云币------------------------*/


+ (void)payCloudValueWithAmount:(NSString *)amount andPayType:(JGPayCloudValueType)payType success:(void(^)(CloudBuyerPaymetResponse *response))success error:(void(^)(NSError *error))errorBlock;

@end
