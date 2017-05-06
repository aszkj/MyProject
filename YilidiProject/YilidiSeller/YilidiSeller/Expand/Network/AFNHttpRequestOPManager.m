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

static AFNHttpRequestOPManager *_shareAFNHttpRequestOPManager = nil;
@implementation AFNHttpRequestOPManager

+ (instancetype)sharedManager{

  
        static dispatch_once_t onceToken;
    
            dispatch_once(&onceToken, ^{
                
                _shareAFNHttpRequestOPManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
                _shareAFNHttpRequestOPManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", nil];
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
        DDLogVerbose(@"请求头---%@",[[[[self class] sharedManager] requestSerializer] HTTPRequestHeaders]);
        NSString *requestUrlStr = [NSString stringWithFormat:@"%@%@",BASEURL,suburl];
        NSDictionary *dealedParam = [[self class] dealEntryParam:Parameters];
        DDLogVerbose(@"请求url---%@",requestUrlStr);
        DDLogVerbose(@"请求参数param---%@",Parameters);

       [[[self class] sharedManager] POST:requestUrlStr parameters:dealedParam
        success:^(NSURLSessionDataTask *task,id responseObject) {
            
        responseObject = [[self class] tranferToNormalResultWithTheBase64Result:responseObject];
        NSError *responseError = nil;
//        BOOL hasError = [[self class] handError:&responseError withResponse:responseObject];
        BOOL hasError = [[self class] handError:&responseError withResponse:responseObject ofRequestUlr:suburl];
        DDLogVerbose(@"响应结果result---%@",responseObject);
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        DDLogVerbose(@"响应头HttpHeaders---%@",response.allHeaderFields);
        DDLogVerbose(@"响应头HttpHeaders---%@",response.allHeaderFields);
        DDLogVerbose(@"响应code -- %ld",response.statusCode);
        DDLogVerbose(@"响应code 描述-- %@",[NSHTTPURLResponse localizedStringForStatusCode:response.statusCode]);
        if (hasError) {
            DDLogError(@"error url = %@",[NSString stringWithFormat:@"%@%@",BASEURL,suburl]);
            DDLogError(@"error code = %ld, erro msg --- %@",responseError.code,responseError.localizedDescription);
        }else {

        }
        
        if (block && responseObject) {
            block(responseObject,responseError);
        }
            
        }failure:^(NSURLSessionDataTask *task,NSError *error) {
            DDLogVerbose(@"error = %@",error.description);
            [[self class] handError:&error withResponse:nil ofRequestUlr:suburl];
            JLog(@"error url = %@",[NSString stringWithFormat:@"%@%@",BASEURL,suburl]);
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            DDLogVerbose(@"响应头HttpHeaders---%@",response.allHeaderFields);
            DDLogVerbose(@"响应code -- %ld",response.statusCode);
            DDLogVerbose(@"响应code 描述-- %@",[NSHTTPURLResponse localizedStringForStatusCode:response.statusCode]);

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
        BOOL hasError = [[self class] handError:&responseError withResponse:responseObject ofRequestUlr:subUrl];
        if (block && responseObject) {
            block(responseObject,responseError);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@",error.description);
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
    NSLog(@"cancelRequest");
    [[[[self class] sharedManager] operationQueue] cancelAllOperations];
 
}


@end

