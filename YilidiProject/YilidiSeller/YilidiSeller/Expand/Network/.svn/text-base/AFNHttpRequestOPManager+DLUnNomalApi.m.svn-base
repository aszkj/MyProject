//
//  AFNHttpRequestOPManager+DLUnNomalApi.m
//  YilidiBuyer
//
//  Created by yld on 16/5/24.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "AFNHttpRequestOPManager+setCookes.h"
#import "AFNHttpRequestOPManager+checkNetworkStatus.h"
#import "AFNHttpRequestOPManager+errorHandle.h"
#import "AFNHttpRequestOPManager+crupo.h"
#import "AFNHttpRequestOPManager+setCookes.h"
#import "GlobleConst.h"
#import "DLRequestUrl.h"

@implementation AFNHttpRequestOPManager (DLUnNomalApi)

#pragma mark -------------------Public Method----------------------
+ (void)loginWithAcount:(NSString *)accountName
                 passwd:(NSString *)passwd
                  block:(void (^)(id result, NSError *error))block
{
    NSDictionary *loginParam = @{@"mobile":accountName,
                                 @"code":passwd,
                                 @"type":KTypeLoginPassword};
    NSString *loginUrlStr = [NSString stringWithFormat:@"%@%@",BASEURL,kUrl_Login];
    NSDictionary *dealedParam = [[self class] dealEntryParam:loginParam];
    [[self class] _handleBeforeLogin];
    [[[self class] sharedManager] POST:loginUrlStr parameters:dealedParam
                                      success:^(NSURLSessionDataTask *task,id responseObject) {
                                        
                                          responseObject = [[self class] tranferToNormalResultWithTheBase64Result:responseObject];
                                          NSError *responseError = nil;
                                          BOOL hasError = [[self class] handError:&responseError withResponse:responseObject ofRequestUlr:kUrl_Login];
                                          if (!hasError) {
                                              NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                                              [[self class] _setCookieAfterLoginResponse:response];
                                          }
                                          if (block && responseObject) {
                                              block(responseObject,responseError);
                                          }
                                          
                                      }failure:^(NSURLSessionDataTask *task,NSError *error) {
                                          NSLog(@"error = %@",error.description);
                                          [[self class] handError:&error withResponse:nil ofRequestUlr:kUrl_Login];
                                          if (block) {
                                              block(nil,error);
                                          }
                                      }];

    
}


+ (void)loginWithPhoneNumber:(NSString *)phoneNumber
                    varyCode:(NSString *)varyCode
                       block:(void (^)(id result, NSError *error))block {
    
    NSDictionary *loginParam = @{@"mobile":phoneNumber,
                                 @"code":varyCode,
                                 @"type":KTypeCodeLogin};
    NSString *loginUrlStr = [NSString stringWithFormat:@"%@%@",BASEURL,kUrl_Login];
    NSDictionary *dealedParam = [[self class] dealEntryParam:loginParam];
    [[self class] _handleBeforeLogin];
    [[self class] setCookiesValue:UNLOGIN_SESSIONID forKey:YiLiDiSessionID];
    NSDictionary *reuqestHeader = [[[[self class] sharedManager] requestSerializer] HTTPRequestHeaders];
    NSLog(@"使用验证码登录接口请求头%@",reuqestHeader);
    [[[self class] sharedManager] POST:loginUrlStr parameters:dealedParam
                               success:^(NSURLSessionDataTask *task,id responseObject) {
                                   
                                   responseObject = [[self class] tranferToNormalResultWithTheBase64Result:responseObject];
                                   NSError *responseError = nil;
                                   BOOL hasError = [[self class] handError:&responseError withResponse:responseObject ofRequestUlr:kUrl_Login];
                                   if (!hasError) {
                                       NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                                       [[self class] _setCookieAfterLoginResponse:response];
                                   }
                                   if (block && responseObject) {
                                       block(responseObject,responseError);
                                   }

                               }failure:^(NSURLSessionDataTask *task,NSError *error) {
                                   NSLog(@"error = %@",error.description);
                                   [[self class] handError:&error withResponse:nil ofRequestUlr:kUrl_Login];
                                   if (block) {
                                       block(nil,error);
                                   }
                               }];

}


+ (NSString *)_valueAtResponseCookesIndex:(NSInteger)cookeArrIndex inResponse:(NSHTTPURLResponse *)response {
    
    NSLog(@"headers -- %@",response.allHeaderFields[@"Set-Cookie"]);
    NSString *sessionIdStr = nil;
    NSString *headerStr = response.allHeaderFields[@"Set-Cookie"];
    NSString *seperatedStr = [YiLiDiSessionID stringByAppendingString:@"="];
    NSArray *headerArrs = [headerStr componentsSeparatedByString:seperatedStr];
    return headerArrs.lastObject;
}



+ (void)requestVaryCodeForPhoneNumber:(NSString *)phoneNumber
                         varyCodeType:(NSNumber *)varyCodeType
                                block:(void (^)(id result, NSError *error))block
{
    
    NSDictionary *requestParam = @{@"mobile":phoneNumber,
                                   @"type":varyCodeType
                                   };
    NSString *loginUrlStr = [NSString stringWithFormat:@"%@%@",BASEURL,kUrl_VerificationCode];
    NSDictionary *dealedParam = [[self class] dealEntryParam:requestParam];
    [[[self class] sharedManager] POST:loginUrlStr parameters:dealedParam
                               success:^(NSURLSessionDataTask *task,id responseObject) {
                                   
                                   NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                                   [[self class] _setCookieAfterLoginResponse:response];
                                   responseObject = [[self class] tranferToNormalResultWithTheBase64Result:responseObject];
                                   NSError *responseError = nil;
                                   BOOL hasError = [[self class] handError:&responseError withResponse:responseObject ofRequestUlr:kUrl_Login];
                                   if (block && responseObject) {
                                       block(responseObject,responseError);
                                   }
                               }failure:^(NSURLSessionDataTask *task,NSError *error) {
                                   NSLog(@"error = %@",error.description);
                                   [[self class] handError:&error withResponse:nil ofRequestUlr:kUrl_Login];
                                   if (block) {
                                       block(nil,error);
                                   }
                               }];


}


#pragma mark -------------------Private Method----------------------
+ (void)_handleBeforeLogin {
    
    [[self class] removeCookieForCookieKey:YiLiDiSessionID];
}

+ (void)_setCookieAfterLogoutResponse:(NSHTTPURLResponse *)response {
    
    NSLog(@"退出登陆后，获取验证码接口相应头%@",response.allHeaderFields);
    NSString *unLoginsessionIdCookieStr = [[self class] _valueAtResponseCookesIndex:0 inResponse:response];
        [kUserDefaults setObject:unLoginsessionIdCookieStr forKey:UNLOGIN_YiLiDiSessionID];
        [kUserDefaults synchronize];
        [[self class] setCookiesValue:unLoginsessionIdCookieStr forKey:YiLiDiSessionID];
    

}

+ (void)_setCookieAfterLoginResponse:(NSHTTPURLResponse *)response {
    [[self class] removeCookieForCookieKey:YiLiDiSessionID];
    NSString *sessionIdCookieStr = [[self class] _valueAtResponseCookesIndex:0 inResponse:response];
    [kUserDefaults setObject:sessionIdCookieStr forKey:YiLiDiSessionID];
    [kUserDefaults synchronize];
    [[self class] setCookiesValue:sessionIdCookieStr forKey:YiLiDiSessionID];
}


@end
