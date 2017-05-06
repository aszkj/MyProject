//
//  NSError+weimiError.m
//  weimi
//
//  Created by 张康健 on 16/2/23.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "NSError+weimiError.h"
#import "XKO_ViewModel.h"
#import "AppDelegate.h"
#import "DatabaseCache.h"
#import "LoginController.h"
#import "XKJHNavRootController.h"

@implementation NSError (weimiError)

+ (UIAlertView *)visibleAlter {
    
    static UIAlertView *visibleAlter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        visibleAlter = [[UIAlertView alloc] initWithTitle:nil message:@"网络异常,连接服务器失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    });
    
    return visibleAlter;
}

+ (NSString *)checkErrorFromServer:(NSError *)error response:(id)output {
    NSString *errorMessage = @"网络异常,连接服务器失败";
    NSString *errorDescription = nil;
    NSInteger errorCode = 0;
    
    if ([output respondsToSelector:@selector(valueForKey:)] && !IsEmpty([output valueForKey:@"errorDescription"]))
    {
        errorDescription = [output valueForKey:@"errorDescription"];
        errorMessage = errorDescription;
        errorCode = [(NSString *)[output valueForKey:@"error"] integerValue];
    } else if (error.localizedDescription.length > 0) {
//        errorMessage = error.localizedDescription;
    } else {
        return nil;
    }
    
    DDLogWarn(@"服务端报错: %@",errorMessage);
    
    UIAlertView *alertView = [NSError visibleAlter];
    [alertView setMessage:errorMessage];
    
    //账号失效，进入登录界面
    if (error.code == 401 || error.code == 403 || errorCode == 401 || errorCode == 403) {
        [alertView setMessage:KInvalidTokenErrorCode];
        [alertView show];
        [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber *indexNumber) {
            [kAppDelegate userExit];
        }];
        return nil;
    }
    
    if (!alertView.visible) {
        [alertView show];
    }
    return errorMessage;
}

+ (NSString *)errorStrWithError:(NSError *)error {
    
    NSString *erroStr = error.localizedDescription;
    NSString *showErrorStr = nil;
    showErrorStr = @"无法连接服务器";
    if ([erroStr rangeOfString:@"400"].length > 0) {
        showErrorStr = @"用户名或密码错误";
    }else if ([erroStr rangeOfString:@"401"].length > 0){
        showErrorStr = @"用户名或密码错误";
    }else if ([erroStr rangeOfString:@"403"].length > 0){
        
    }else if ([erroStr rangeOfString:@"404"].length > 0){
        
    }else if ([erroStr rangeOfString:@"201"].length > 0){
        
    }
    
    UIAlertView *alertView = [NSError visibleAlter];
    [alertView setMessage:showErrorStr];
    
    if (!alertView.visible) {
        [alertView show];
    }
    
    return showErrorStr;
}


@end
