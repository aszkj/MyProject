//
//  DLHttpRequestManager.m
//  YilidiSeller
//
//  Created by yld on 16/3/23.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import "AFNHttpRequestOPManager.h"
#import "AFNHttpRequestOPManager+crupo.h"
#import "AFNHttpRequestOPManager+checkNetworkStatus.h"
#import "AFNHttpRequestOPManager+errorHandle.h"
#import "AFNHttpRequestOPManager+ExternParams.h"
#import "AFNHttpRequestOPManager+setCookes.h"
#import "AFNHttpRequestOPManager+log.h"
#import "GlobleConst.h"

static AFNHttpRequestOPManager *_shareAFNHttpRequestOPManager = nil;
@implementation AFNHttpRequestOPManager

+ (instancetype)sharedManager{
    
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _shareAFNHttpRequestOPManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
//        _shareAFNHttpRequestOPManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", nil];
        _shareAFNHttpRequestOPManager.responseSerializer.acceptableContentTypes = nil;//[NSSet setWithObject:@"text/ plain"];
        _shareAFNHttpRequestOPManager.securityPolicy = [AFSecurityPolicy defaultPolicy];
        _shareAFNHttpRequestOPManager.securityPolicy.allowInvalidCertificates = YES;//忽略https证书
        _shareAFNHttpRequestOPManager.securityPolicy.validatesDomainName = NO;//是否验证域名
        _shareAFNHttpRequestOPManager.requestSerializer.HTTPShouldHandleCookies = NO;
    });
    return _shareAFNHttpRequestOPManager;
}

#pragma mark -- post method
+ (void )postWithParameters:(NSDictionary *)Parameters
                     subUrl:(NSString *)suburl
                      block:(void (^)(NSDictionary *resultDic, NSError *error))block
{
    
    [[self class] setSessionIdCookie];
    [[self class] checkNetWorkStatus];
    [[self class] logWithRequestParam:Parameters requestUrl:suburl];
    
    NSString *requestUrlStr = [NSString stringWithFormat:@"%@%@",BASEURL,suburl];
    NSDictionary *dealedParam = [[self class] dealEntryParam:Parameters];
    [[[self class] sharedManager] POST:requestUrlStr parameters:dealedParam
                               success:^(NSURLSessionDataTask *task,id responseObject) {
                                   
                                   responseObject = [[self class] tranferToNormalResultWithTheBase64Result:responseObject];
                                   NSError *responseError = nil;
                                  [[self class] handError:&responseError withResponse:responseObject ofRequestUlr:suburl];
                                   
                                   NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                                   [[self class] cacheCookieAfterRequestWithResponse:response];
                                   
                                   [[self class] logWithResponseObject:responseObject htppResponse:response responseErrorInfo:responseError requestUrl:suburl requestParam:Parameters];
                                   
                                   if (block && responseObject) {
                                       block(responseObject,responseError);
                                   }
                                   
                               }failure:^(NSURLSessionDataTask *task,NSError *error) {
                                   [[self class] handError:&error withResponse:nil ofRequestUlr:suburl];
                                   NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                                   NSDictionary *errorUserInfo = @{NSLocalizedDescriptionKey:error.localizedDescription};
                                   error = [NSError errorWithDomain:@"请求服务器出错" code:-1 userInfo:errorUserInfo];
                                   [[self class] logWithResponseObject:nil htppResponse:response responseErrorInfo:error requestUrl:suburl requestParam:Parameters];
                                   if (block) {
                                       block(nil,error);
                                   }
                               }];
}


+ (void)getInfoWithSubUrl:(NSString *)subUrl
               parameters:(NSDictionary *)Parameters
                    block:(void (^)(id result, NSError *error))block{
    [[self class] checkNetWorkStatus];
    
    JLog(@"url = %@",[NSString stringWithFormat:@"%@%@",BASEURL,subUrl]);
    NSString *requestUrlStr = [NSString stringWithFormat:@"%@%@",BASEURL,subUrl];
    
    NSDictionary *dealedParam = [[self class] dealEntryParam:Parameters];
    
    [[[self class] sharedManager] GET:requestUrlStr parameters:dealedParam success:^(NSURLSessionDataTask *task, id responseObject) {
        responseObject = [[self class] tranferToNormalResultWithTheBase64Result:responseObject];
        NSError *responseError = nil;
        [[self class] handError:&responseError withResponse:responseObject ofRequestUlr:subUrl];
        if (block && responseObject) {
            block(responseObject,responseError);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        JLog(@"error = %@",error.description);
        [[self class] handError:&error withResponse:nil ofRequestUlr:subUrl];
        if (block) {
            block(nil,error);
        }
    }];
    
}

+ (NSDictionary *)dealEntryParam:(NSDictionary *)entryParam {
    NSDictionary *baseParam = nil;
    if (entryParam) {
        baseParam = @{@"entity":entryParam};
    }
    NSDictionary *baseExternParam = [[self class] setNormExternParamAtBaseParam:baseParam];
    NSDictionary *base64Param = [[self class] transferToBase64ParamWithTheBasicParam:baseExternParam];
    return base64Param;
}



#pragma mark 取消网络请求
+ (void)cancelRequest{
    JLog(@"cancelRequest");
    [[[[self class] sharedManager] operationQueue] cancelAllOperations];
    
}


@end

