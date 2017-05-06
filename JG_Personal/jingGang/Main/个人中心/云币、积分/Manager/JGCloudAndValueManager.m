//
//  JGCloudAndValueManager.m
//  jingGang
//
//  Created by dengxf on 16/1/11.
//  Copyright © 2016年 yi jiehuang. All rights reserved.
//

#import "JGCloudAndValueManager.h"
#import "GlobeObject.h"

NSString * const kCloudAndValuePayPasswordKey = @"kCloudAndValuePayPasswordKey";

@implementation JGCloudAndValueManager

+ (void)inquiryCashDefaultsType:(void (^)(CloudForm *cloudPredepositCash))success fail:(void (^)())fail error:(void (^)(NSError *))errorBlock {
    VApiManager *manager = [[VApiManager alloc] init];
    CloudBuyerQueryOnlyOneRequest *request = [[CloudBuyerQueryOnlyOneRequest alloc] init:GetToken];
    
    [manager cloudBuyerQueryOnlyOne:request success:^(AFHTTPRequestOperation *operation, CloudBuyerQueryOnlyOneResponse *response) {
        if (response.cloudPredepositCash) {
            BLOCK_EXEC(success,response.cloudPredepositCash);
        }else {
            BLOCK_EXEC(fail);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        JGLog(@"error");
        BLOCK_EXEC(errorBlock,error);
    }];
}

+ (void)inquiryUserCurrentLoginPhoneNumber:(void (^)(NSString *))loginName error:(void (^)(NSError *))errorBlock {
    VApiManager *manager = [[VApiManager alloc] init];
    CloudBuyerMoneyPasswordRequest *request = [[CloudBuyerMoneyPasswordRequest alloc] init:GetToken];
    [manager cloudBuyerMoneyPassword:request success:^(AFHTTPRequestOperation *operation, CloudBuyerMoneyPasswordResponse *response) {
        BLOCK_EXEC(loginName,response.loginName);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BLOCK_EXEC(errorBlock,error);
    } ];
}

+ (void)inquiryUserDidSetPayPasswordWithResult:(void (^)(BOOL))result error:(void (^)(NSError *))errorBlock {
    VApiManager *manager = [[VApiManager alloc] init];

    CloudBuyerPasswordIsNullRequest *request = [[CloudBuyerPasswordIsNullRequest alloc] init:GetToken];
    [manager cloudBuyerPasswordIsNull:request success:^(AFHTTPRequestOperation *operation, CloudBuyerPasswordIsNullResponse *response) {
        
        BLOCK_EXEC(result,[response.ret integerValue]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        BLOCK_EXEC(errorBlock,error);
        
    }];
}

+ (void)sendMsmToPhoneValidateWithPhoneNumber:(NSString *)phoneNumber success:(void (^)(NSString *msg))success fail:(void (^)(void))fail {
    VApiManager *manager = [[VApiManager alloc] init];
    CloudBuyerMobileSmsRequest *request = [[CloudBuyerMobileSmsRequest alloc] init:GetToken];
    request.api_type = @"password_vetify_code";
    request.api_mobile = @"";
    
    [manager cloudBuyerMobileSms:request success:^(AFHTTPRequestOperation *operation, CloudBuyerMobileSmsResponse *response) {

        BLOCK_EXEC(success,response.subMsg);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        JGLog(@"res:%@",error.domain);
        BLOCK_EXEC(fail);
        
    }];
}

+ (void)st_userCashPayPasswordWithPswd:(NSString *)password valiteCode:(NSString *)code success:(void (^)(CloudBuyerMoneyPasswordSaveResponse *))success error:(void (^)(NSError *))errorBlock{
    // 应该需要发送网络请求 请求成功才能保存到本地
    VApiManager *manager = [[VApiManager alloc] init];
    CloudBuyerMoneyPasswordSaveRequest *request = [[CloudBuyerMoneyPasswordSaveRequest alloc] init:GetToken];
    request.api_new_password = password;
    request.api_mobile_verify_code = code;
    [manager cloudBuyerMoneyPasswordSave:request success:^(AFHTTPRequestOperation *operation, CloudBuyerMoneyPasswordSaveResponse *response) {
        JGLog(@"response:%@",response);
        BLOCK_EXEC(success,response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        JGLog(@"error:%@",error);
        BLOCK_EXEC(errorBlock,error);
    }];
}

+ (void)validateUserCashPayPassword:(NSString *)password success:(void (^)(BOOL))success error:(void (^)(NSError *))errorBlock {
    VApiManager *manager = [[VApiManager alloc] init];
    CloudBuyerMoneyPasswordValidateRequest *request = [[CloudBuyerMoneyPasswordValidateRequest alloc] init:GetToken];
    request.api_paymentPassword = password;
    [manager cloudBuyerMoneyPasswordValidate:request success:^(AFHTTPRequestOperation *operation, CloudBuyerMoneyPasswordValidateResponse *response) {
        BLOCK_EXEC(success,[response.ret integerValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BLOCK_EXEC(errorBlock,error);
    }];
}

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
                        success:(void (^)(CloudBuyerCashSaveResponse *))success
                           fail:(void (^)(NSString *))fail
                          error:(void (^)(NSError *))errorBlock{
    VApiManager *manager = [[VApiManager alloc] init];
    CloudBuyerCashSaveRequest *request = [[CloudBuyerCashSaveRequest alloc] init:GetToken];
    request.api_cashAmount = [NSNumber numberWithFloat:cashAmount];
    request.api_cashUserName = cashUserName;
    request.api_cashAccount = cashAccount;
    request.api_cashPassword = cashPassword;
    request.api_cashInfo = cashInfo;
    request.api_cashRelation = [NSNumber numberWithInteger:1];
    if (needCashId) {
        // 需要 cashid
        request.api_cashId = [NSNumber numberWithFloat:cashId];
        JGLog(@"\n使用默认cashId：%f",cashId);
    }else {
        JGLog(@"cash为空");
    }
//    request.api_userType = [NSNumber numberWithInteger:1]; // 用户类型  //可不填
    switch (payment) {
        case CashPayBankType:
        {
            // 银行
            request.api_cashPayment = @"chinabank";
            request.api_cashBank = cashBank;
            request.api_cashSubbranch = cashSubbranch;

        }
            break;
        case CashPayAliType:
        {
            // 支付宝
            request.api_cashPayment = @"alipay";
            request.api_cashBank = @"";
            request.api_cashSubbranch = @"";

        }
        default:
            break;
    }
    [manager cloudBuyerCashSave:request success:^(AFHTTPRequestOperation *operation, CloudBuyerCashSaveResponse *response) {
        BOOL ret = [response.isCompletePay integerValue];
        if (ret) {
            // 提现成功
            BLOCK_EXEC(success,response);
        }else {
            BLOCK_EXEC(fail,response.subMsg);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BLOCK_EXEC(errorBlock,error);
    }];
}


/** -------------------------充值云币------------------------*/
+ (void)payCloudValueWithAmount:(NSString *)amount andPayType:(JGPayCloudValueType)payType success:(void (^)(CloudBuyerPaymetResponse *))success error:(void (^)(NSError *))errorBlock {
    VApiManager *manager = [[VApiManager alloc] init];
    CloudBuyerPaymetRequest *request = [[CloudBuyerPaymetRequest alloc] init:GetToken];
    request.api_pdAmount = [NSNumber numberWithFloat:[amount floatValue]];
    /**
     *  api_pdPayment; 支付类型 wx_app   alipay_app */
    NSString *payment = @"";
    switch (payType) {
        case JGPayCloudValueWithWXType:
            payment = @"wx_app";
            break;
        case JGPayCloudValueWithAliType:
            payment = @"alipay_app";
            break;
        default:
            break;
    }
    request.api_pdPayment = payment;
    
    [manager cloudBuyerPaymet:request success:^(AFHTTPRequestOperation *operation, CloudBuyerPaymetResponse *response) {
        
        JGLog(@"res:%@",response);
        BLOCK_EXEC(success,response);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        JGLog(@"error:%@",error);
    }];
}


@end
