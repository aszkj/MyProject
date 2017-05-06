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
                                          JLog(@"error = %@",error.description);
                                          [[self class] handError:&error withResponse:nil ofRequestUlr:kUrl_Login];
                                          if (block) {
                                              block(nil,error);
                                          }
                                      }];

    
}


+ (void)wechatAndlogin:(NSDictionary *)loginParam
             submitUrl:(NSString *)url
                  block:(void (^)(id result, NSError *error))block
{
    
    NSString *loginUrlStr = [NSString stringWithFormat:@"%@%@",BASEURL,url];
    NSDictionary *dealedParam = [[self class] dealEntryParam:loginParam];
    [[[self class] sharedManager] POST:loginUrlStr parameters:dealedParam
                               success:^(NSURLSessionDataTask *task,id responseObject) {
                                   
                                   responseObject = [[self class] tranferToNormalResultWithTheBase64Result:responseObject];
                                   NSError *responseError = nil;
                                   BOOL hasError = [[self class] handError:&responseError withResponse:responseObject ofRequestUlr:url];
                                   if (!hasError) {
                                       NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                                       [[self class] _setCookieAfterLoginResponse:response];
                                   }
                                   if (block && responseObject) {
                                       block(responseObject,responseError);
                                   }
                                   
                               }failure:^(NSURLSessionDataTask *task,NSError *error) {
                                   JLog(@"error = %@",error.description);
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
    [[self class] setSessionIdCookie];
    NSDictionary *reuqestHeader = [[[[self class] sharedManager] requestSerializer] HTTPRequestHeaders];
    JLog(@"使用验证码登录接口请求头%@",reuqestHeader);
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
                                   JLog(@"error = %@",error.description);
                                   [[self class] handError:&error withResponse:nil ofRequestUlr:kUrl_Login];
                                   if (block) {
                                       block(nil,error);
                                   }
                               }];

}


+ (void)bingdingPhoneLogin:(NSDictionary *)dic
                       block:(void (^)(id result, NSError *error))block {
    
    
    NSString *loginUrlStr = [NSString stringWithFormat:@"%@%@",BASEURL,kUrl_Binding];
    NSDictionary *dealedParam = [[self class] dealEntryParam:dic];
    [[self class] setSessionIdCookie];
    NSDictionary *reuqestHeader = [[[[self class] sharedManager] requestSerializer] HTTPRequestHeaders];
    JLog(@"使用验证码登录接口请求头%@",reuqestHeader);
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
                                   JLog(@"error = %@",error.description);
                                   [[self class] handError:&error withResponse:nil ofRequestUlr:kUrl_Login];
                                   if (block) {
                                       block(nil,error);
                                   }
                               }];
    
}




+ (void )postUserHeadImageData:(NSData *)data
                     imageUrl :(NSString *)headUrl
                        subUrl:(NSString *)suburl
                         block:(void (^)(NSDictionary *resultDic, NSError *error))block
{
    
    [[self class] setSessionIdCookie];
    [[self class] checkNetWorkStatus];
    JLog(@"请求头---%@",[[[[self class] sharedManager] requestSerializer] HTTPRequestHeaders]);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *requestUrlStr = [NSString stringWithFormat:@"%@%@",POSTIMAGEURL,suburl];
    
    [manager POST:requestUrlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:@"file" fileName:headUrl mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *responseError = nil;
        
        NSLog(@"responseObject..%@",responseObject);
        BOOL hasError = [[self class] handError:&responseError withResponse:responseObject ofRequestUlr:suburl];
        if (hasError) {
            JLog(@"error url = %@",[NSString stringWithFormat:@"%@%@",POSTIMAGEURL,suburl]);
        }
        
        if (block && responseObject) {
            block(responseObject,responseError);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        JLog(@"error = %@",error.description);
        [[self class] handError:&error withResponse:nil ofRequestUlr:suburl];
        JLog(@"error url = %@",[NSString stringWithFormat:@"%@%@",POSTIMAGEURL,suburl]);
        if (block) {
            block(nil,error);
        }
        
    }];
    
    
    
}


+ (NSString *)_valueAtResponseCookesIndex:(NSInteger)cookeArrIndex inResponse:(NSHTTPURLResponse *)response {
    
    NSString *headerSetCookieStr = response.allHeaderFields[@"Set-Cookie"];
    [kUserDefaults setObject:headerSetCookieStr forKey:KSetCookieKey];
    [kUserDefaults synchronize];
    NSString *seperatedStr = [YiLiDiSessionID stringByAppendingString:@"="];
    NSArray *headerArrs = [headerSetCookieStr componentsSeparatedByString:seperatedStr];
    return headerArrs.lastObject;
}


+ (void)requestNearbyShopWithlongtitude:(CGFloat)longtide
                               latitude:(CGFloat)latitude
                                  block:(void (^)(id result, NSError *error))block
{
    NSDictionary *requestNearbyParam = @{@"longitude":@(longtide),@"latitude":@(latitude)};
    [[self class] postWithParameters:requestNearbyParam subUrl:kUrl_GetNeartyDefaultShop block:^(NSDictionary *resultDic, NSError *error) {
        block(resultDic,error);
        
    }];
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
    [[self class] setSessionIdCookie];
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
                                   JLog(@"error = %@",error.description);
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
    [[self class] removeCookieForCookieKey:YiLiDiSessionID];
    [kUserDefaults setObject:nil forKey:YiLiDiSessionID];
    NSString *unLoginsessionIdCookieStr = [[self class] _valueAtResponseCookesIndex:0 inResponse:response];
    [kUserDefaults setObject:unLoginsessionIdCookieStr forKey:UNLOGIN_YiLiDiSessionID];
    [kUserDefaults synchronize];
}

+ (void)_setCookieAfterLoginResponse:(NSHTTPURLResponse *)response {
    [[self class] removeCookieForCookieKey:YiLiDiSessionID];
    [kUserDefaults setObject:nil forKey:UNLOGIN_YiLiDiSessionID];
    NSString *sessionIdCookieStr = [[self class] _valueAtResponseCookesIndex:0 inResponse:response];
    [kUserDefaults setObject:sessionIdCookieStr forKey:YiLiDiSessionID];
    [kUserDefaults synchronize];
}


@end
