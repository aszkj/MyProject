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
#import "AFNHttpRequestOPManager+log.h"

@implementation AFNHttpRequestOPManager (DLUnNomalApi)

#pragma mark -------------------Public Method----------------------
+ (void )postUserHeadImageData:(NSData *)data
                     imageUrl :(NSString *)headUrl
                        subUrl:(NSString *)suburl
                         block:(void (^)(NSDictionary *resultDic, NSError *error))block
{
    
    [[self class] setSessionIdCookie];
    [[self class] checkNetWorkStatus];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *requestUrlStr = [NSString stringWithFormat:@"%@%@",BASEURL,suburl];
    NSDictionary *param = @{@"file":@"image/png"};
    [[self class] logWithRequestParam:param requestUrl:suburl];

    [[self sharedManager] POST:requestUrlStr parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:@"file" fileName:headUrl mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        responseObject = [[self class] tranferToNormalResultWithTheBase64Result:responseObject];
        NSError *responseError = nil;
        [[self class] handError:&responseError withResponse:responseObject ofRequestUlr:suburl];
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        [[self class] cacheCookieAfterRequestWithResponse:response];
        
        [[self class] logWithResponseObject:responseObject htppResponse:response responseErrorInfo:responseError requestUrl:suburl requestParam:param];
        
        if (block && responseObject) {
            block(responseObject,responseError);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self class] handError:&error withResponse:nil ofRequestUlr:suburl];
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *errorUserInfo = @{NSLocalizedDescriptionKey:error.localizedDescription};
        error = [NSError errorWithDomain:@"上传图片超时，请重新上传" code:-1 userInfo:errorUserInfo];
        [[self class] logWithResponseObject:nil htppResponse:response responseErrorInfo:error requestUrl:suburl requestParam:param];
        if (block) {
            block(nil,error);
        }
        
    }];
    
    
    
}


+ (void)requestNearbyShopWithlongtitude:(CGFloat)longtide
                               latitude:(CGFloat)latitude
                                  block:(void (^)(id result, NSError *error))block
{
    //,@"testLinkServer":@"canlinkServer"
    NSDictionary *requestNearbyParam = @{@"longitude":@(longtide),@"latitude":@(latitude)};
    [[self class] postWithParameters:requestNearbyParam subUrl:kUrl_GetNeartyDefaultShop block:^(NSDictionary *resultDic, NSError *error) {
        block(resultDic,error);
        
    }];
}


@end
