//
//  AFNHttpRequestOPManager+errorHandle.m
//  YilidiBuyer
//
//  Created by yld on 16/5/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "AFNHttpRequestOPManager+errorHandle.h"
#import "DLLoginVC.h"
#import "DLBaseNavController.h"
#import "Util.h"
#import "GlobleConst.h"
#import "NSObject+SUIAdditions.h"
#import "AlertViewManager.h"
static NSString *serviceRequestErrorStr = @"连接服务器超时";
const void *needNotLogApisKey = @"needNotLogApisKey";
const void *hasGotoAppstorePageKey = @"hasGotoAppstorePageKey";
const void *hasGotoLoginPageKey = @"hasGotoLoginPageKey";

@implementation AFNHttpRequestOPManager (errorHandle)

+ (BOOL)handError:(NSError **)error withResponse:(id)response ofRequestUlr:(NSString *)requestUrlStr{
    
    NSDictionary *errorUserInfo = nil;
    if (*error) {
        errorUserInfo = @{NSLocalizedDescriptionKey:serviceRequestErrorStr};
        *error = [NSError errorWithDomain:serviceRequestErrorStr code:RequestFailedServiceErrorCode userInfo:errorUserInfo];
        if (![[self class] needNotLogOfUrl:requestUrlStr]) {
            [Util ShowAlertWithOnlyMessage:serviceRequestErrorStr];
        }
        return YES;
    }
    
    if (response) {
        
        NSInteger errorCode = [response[@"msgCode"] integerValue];
        NSString *errorMsg = response[@"msg"];
        errorUserInfo = @{NSLocalizedDescriptionKey:errorMsg};
        *error = [NSError errorWithDomain:errorMsg code:errorCode userInfo:errorUserInfo];
        
        if (errorCode == RequestFailedUnloginCode) {//未登录，或登陆超时
            [[self class] _enterLoginPage];
            return YES;
        }
        
        if (errorCode == RequestNeedForceUpdate) {
            [[self class] alertAppToUpdate];
            return YES;
        }
        
        if (errorCode != RequestSuccessCode) {//有错
            if (![[self class] needNotLogOfUrl:requestUrlStr]) {
                [Util ShowAlertWithOnlyMessage:errorMsg];
            }
            return YES;
        }
        
        return NO;
    }
    return NO;
}

+ (void)alertAppToUpdate {

    AFNHttpRequestOPManager *manager = [self sharedManager];
    BOOL hasGoneAppstorePage =  [[manager sui_getAssociatedObjectWithKey:hasGotoAppstorePageKey] boolValue];
    if (hasGoneAppstorePage) {
        return;
    }
    AlertViewManager *alertManager = [[AlertViewManager alloc] init];
    [alertManager showAlertViewWithControllerTitle:@"提示" message:@"应用需要升级" controllerStyle:UIAlertControllerStyleAlert isHaveTextField:NO actionTitle:@"确定" actionStyle:UIAlertActionStyleDefault alertViewAction:^(UIAlertAction *action) {
        [[self class] apiUpdateToGotoAppStore];
    }];
}

+ (void)apiUpdateToGotoAppStore {
    AFNHttpRequestOPManager *manager = [self sharedManager];
    [manager sui_setAssociatedAssignObject:@(YES) key:hasGotoAppstorePageKey];
    NSURL *buyerAppSoreUrl = [NSURL URLWithString:kBuyerAppstoreLinkAdress];
    [[UIApplication sharedApplication] openURL:buyerAppSoreUrl];
}

+ (BOOL)needNotLogOfUrl:(NSString *)url {
    
    AFNHttpRequestOPManager *manager = [self sharedManager];
    NSArray *needNotLogApis =  [manager sui_getAssociatedObjectWithKey:needNotLogApisKey];
    if (isEmpty(needNotLogApis) || !needNotLogApis.count) {
        NSDictionary *apiDic = [[self class] apiUrlDic];
        needNotLogApis = apiDic[@"noNeedLogError"];
        [manager sui_setAssociatedCopyObject:needNotLogApis key:needNotLogApisKey];
    }
    
    if (isEmpty(needNotLogApis)) {
        return YES;
    }
    
    __block BOOL urlIsInTheNeedNotLogApis = NO;
    [needNotLogApis enumerateObjectsUsingBlock:^(NSString *apiUrl, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([url isEqualToString:apiUrl]) {
            urlIsInTheNeedNotLogApis = YES;
            * stop = YES;
        }
    }];
    
    return urlIsInTheNeedNotLogApis;
}

+ (NSDictionary *)apiUrlDic {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"apiUrl" ofType:@"plist"];
    NSDictionary *apiDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    return apiDic;
}

+ (void)_enterLoginPage {
    
    DLLoginVC *loginVC = [[DLLoginVC alloc] init];
    loginVC.comeToLoginPageType = LoginedComin_FromSessionInvalidate;
    DLBaseNavController *loginNav = [[DLBaseNavController alloc] initWithRootViewController:loginVC];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:loginNav animated:YES completion:nil];

}

@end
