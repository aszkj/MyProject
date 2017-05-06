//
//  VApiManager+Aspects.m
//  jingGang
//
//  Created by ray on 15/11/9.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "VApiManager+Aspects.h"
#import "GlobeObject.h"
#import <objc/runtime.h>
#import "AppDelegate.h"

@implementation VApiManager (Aspects)

#define loginCode 1212
#define KInvalidTokenErrorCode     @"您的账号已失效,请重新登录!"

static BOOL isfirst;

+ (UIAlertView *)alertViewInstances
{
    static id obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        obj = [[UIAlertView alloc] initWithTitle:@"" message:nil delegate:[self sharedInstance] cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    });
    return obj;
}

+ (instancetype)sharedInstance
{
    static id obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        obj = [[self alloc] init];
    });
    return obj;
}

+ (NSArray *)noTokenApiArray {
    static NSArray *noTokenApiArray = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"NoTokenApi" ofType:@"plist"];
        noTokenApiArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
    });
    return noTokenApiArray;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( [alertView.title isEqualToString:KInvalidTokenErrorCode] ||
        (buttonIndex == 1 && alertView.tag == loginCode)) {
        //退出登录需要设置不接收推送消息,暂时这样做
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
        AppDelegate * app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        [app beGinLogin];
    }
    alertView.title = @"";
    isfirst = NO;
}


+ (void)load
{
    // All methods that trigger height cache's invalidation
    SEL selectors[] = {
        @selector(POST:parameters:success:failure:),
    };
    
    for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
        SEL originalSelector = selectors[index];
        SEL swizzledSelector = NSSelectorFromString([@"xk_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (AFHTTPRequestOperation *)xk_POST:(NSString *)URLString
                         parameters:(id)parameters
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    BOOL needToken = [[self class] apiNeedToken:URLString];
    //不需要,但不是登录接口，设置请求头
    if (!needToken && ![URLString rangeOfString:@"/oauth2/token"].length > 0) {
        [self.requestSerializer setValue:nil forHTTPHeaderField:@"Authorization"];
        [self.requestSerializer setValue:nil forHTTPHeaderField:@"Content-Type" ];
    }
    //未登录，但是该接口需要token,但不是这两个接口，---》提示该接口需要登录   //
    if ([[self class] checkTokenEmpty] && needToken && [URLString rangeOfString:@"users/invitation_all/list"].length == 0 &&  [URLString rangeOfString:@"users/circle_invitation/list"].length == 0 && [URLString rangeOfString:@"users/integral/get"].length == 0 && [URLString rangeOfString:@"users/sign/login"].length == 0) {
        [self handleNeedTokenError];
        
        failure(nil,nil);
        return nil;
    } else {//登录，token失效，未登录，不需要token,
        void (^hookSuccess)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id responseObject){
            if (![URLString rangeOfString:@"/oauth2/token"].length > 0
                && ![self CheckErrorCode:responseObject urlStr:URLString]) {//登录，token失效
                NSLog(@"--------\n接口报错：URLString：%@\n--------",URLString);
//                success(operation,nil);
                
                
                failure(nil,nil);
                
            } else {//未登录，不需要token
                success(operation,responseObject);
            }
        };
        return [self xk_POST:URLString parameters:parameters success:hookSuccess failure:failure];
    }
}

/**
 *  检查服务器是否返回了错误信息
 *
 *  @param response 服务器返回信息
 *
 *  @return Yes:没有错误信息；No:有错误信息；
 */
- (BOOL)CheckErrorCode:(AbstractResponse *)response urlStr:(NSString *)urlStr{
    if ([response isKindOfClass:[AbstractResponse class]] && IsEmpty(response.errorCode)) {//成功
        return YES;
    } else {//errorCode==2,token失效
        
        if ([urlStr rangeOfString:@"users/integral/get"].length > 0 || [urlStr rangeOfString:@"users/sign/login"].length > 0) {
            return NO;
        }
        
    
        UIAlertView *alert = [[self class] alertViewInstances];
        if (!isfirst) {
            if (response.errorCode.integerValue == 2) {
                alert.tag = loginCode;
                //退出登录需要设置不接收推送消息,暂时这样做
                [[UIApplication sharedApplication] unregisterForRemoteNotifications];
                
                // 友盟统计  停止sign-in PUID的统计
                [MobClick profileSignOff];
                
                NSString *title = KInvalidTokenErrorCode;
                alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:[[self class]sharedInstance] cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                isfirst = YES;
                return NO;
            }
        }
        return YES;
    }
}

- (void)handleNeedTokenError {
    [[self class] handleNeedTokenError];
}

+ (void)handleNeedTokenError {
    UIAlertView *alert = [[self class] alertViewInstances];
    if (!isfirst) {
        // 友盟统计  停止sign-in PUID的统计
        [MobClick profileSignOff];
        NSString *title = @"此功能需要登录,请先登录";
        alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:[self sharedInstance] cancelButtonTitle:nil otherButtonTitles:@"取消",@"确定", nil];
        alert.tag = loginCode;
        [alert show];
        isfirst = YES;
    }
}

+ (BOOL)apiNeedToken:(NSString *)URLString {
    
    NSArray *urlArray = [[self class] noTokenApiArray];
    for (NSString *noTokenUrl in urlArray) {
        if ([URLString rangeOfString:noTokenUrl].length > 0) {
            return NO;
        };
    }
    return YES;
}

+ (BOOL)checkTokenEmpty {
    return isEmpty(GetToken) ? YES : NO;
}

@end
