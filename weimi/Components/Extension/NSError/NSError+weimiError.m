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
    NSString *errorCode = @"";
    
    if ([output respondsToSelector:@selector(valueForKey:)]
               && !IsEmpty([output valueForKey:@"errorDescription"])) {
        errorDescription = [output valueForKey:@"errorDescription"];
        errorMessage = errorDescription;
        errorCode = (NSString *)[output valueForKey:@"error"];
    } else if (error.localizedDescription.length > 0) {
        errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
#if DEBUG
        errorMessage = error.localizedDescription;
#endif
    } else {
        return nil;
    }
    
    DDLogWarn(@"服务端报错: %@",errorMessage);
    
    UIAlertView *alertView = [NSError visibleAlter];
    [alertView setMessage:errorMessage];

    if (error.code == 2 || [errorMessage containsString:@"401"]
        || [errorCode containsString:@"401"]) {
        [alertView setMessage:KInvalidTokenErrorCode];
        [[[alertView rac_buttonClickedSignal] take:1] subscribeNext:^(NSNumber *indexNumber) {
            
            [kAppDelegate userExit];
        }];
    }
    
    if (!alertView.visible) {
        [alertView show];
    }
    return errorMessage;
}

+ (NSString *)errorStrWithError:(NSError *)error {
    
    NSString *erroStr = error.localizedDescription;
    NSString *showErrorStr = nil;
    showErrorStr = @"内部服务器错误";
    if ([erroStr rangeOfString:@"400"].length > 0 ||
        [erroStr rangeOfString:@"401"].length > 0) {
        showErrorStr = @"用户名或密码错误";
    } else if ([erroStr rangeOfString:@"403"].length > 0){
        
    } else if ([erroStr rangeOfString:@"404"].length > 0){
        
    } else if ([erroStr rangeOfString:@"201"].length > 0){
        
    }
    
    UIAlertView *alertView = [NSError visibleAlter];
    [alertView setMessage:showErrorStr];
    
    if (!alertView.visible) {
        [alertView show];
    }
    
    return showErrorStr;
}

@end
