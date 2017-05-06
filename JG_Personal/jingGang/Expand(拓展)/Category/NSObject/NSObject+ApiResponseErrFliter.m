//
//  NSObject+ApiResponseErrFliter.m
//  jingGang
//
//  Created by thinker_des on 15/6/28.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "NSObject+ApiResponseErrFliter.h"
#import  <UIKit/UIKit.h>
#import "AbstractResponse.h"
#import "PublicInfo.h"
#import "GlobeObject.h"




@interface NSObjectAlertDelegate : NSObject<UIAlertViewDelegate>
@property (nonatomic, copy) void (^returnBlock)(BOOL event);

@end

@implementation NSObjectAlertDelegate

+ (instancetype)sharedInstance
{
    static NSObjectAlertDelegate *s_NSObjectAlertDelegate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_NSObjectAlertDelegate = [[NSObjectAlertDelegate alloc] init];
    });
    return s_NSObjectAlertDelegate;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView cancelButtonIndex]) {
        if (self.returnBlock) {
            self.returnBlock(YES);
        }
    }else {
        if (self.returnBlock) {
            self.returnBlock(NO);
        }
    }
    self.returnBlock = nil;
}

@end

@interface NSObject(UIAlert)
+ (void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg block:(void (^)(BOOL event))block;
@end

@implementation NSObject(UIAlert)

+ (void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg block:(void (^)(BOOL event))block
{
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:title message:msg delegate:[NSObjectAlertDelegate sharedInstance] cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [[NSObjectAlertDelegate sharedInstance] setReturnBlock:block];
    [alt show];
}

@end

@implementation NSObject (ApiResponseErrFliter)

+ (void)fliterResponse:(AbstractResponse *)response withBlock:(void (^)(int event, id responseObject))block
{
    if([response errorCode]) {
        int errCode = [[response errorCode] intValue];
        //1 系统错误
        //2 token失败
        //3 参数错误
        //4.5 subMsg
        NSString *msg = nil;
        if (errCode == 1) {
            msg = @"系统错误";
        }else if (errCode == 2) {

        }else if (errCode == 3) {
            msg = @"参数错误";
        }else {
            msg = response.subMsg;
        }
        
        if (block) {
            block (0, response);
        }
        
        if ([msg length]) {
            if (![NSObjectAlertDelegate sharedInstance].returnBlock) {//同时只出现一个提示框
                [NSObject showAlertWithTitle:nil msg:msg block:nil];
            }
        }
        if (errCode == 2) {
            //警告框提示后,清除token,退出应用，让用户重新登录
            if (![NSObjectAlertDelegate sharedInstance].returnBlock) {//同时只出现一个提示框
                [NSObject showAlertWithTitle:nil msg:@"请重新登录" block:^(BOOL event) {
                    //
                    if (event) {
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Token"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
//                        exit(0);
                        [Util enterLoginPage];
        
                    }
                }];
            }
        }
    }else {
        if (block) {
            block(1, response);
        }
    }
}

@end
