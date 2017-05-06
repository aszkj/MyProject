//
//  KeyChainManager.m
//  BaiYing_Thinker
//
//  Created by ray on 16/1/14.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "KeyChainManager.h"
#import "SSKeychain.h"
#import "NSString+MD5.h"

@implementation KeyChainManager

static NSString *service = @"com.thinker.weimi";
static NSString *deviceTokenName = @"DeviceToken";
static NSString *APPIDName = @"APPID";

+ (NSString *)getDeviceToken
{
    return [SSKeychain passwordForService:service account:deviceTokenName ];
}

+ (void)setDeviceToken:(NSString *)deviceToken;
{
    if ([KeyChainManager getDeviceToken] == nil) {
        [SSKeychain setPassword:deviceToken forService:service account:deviceTokenName];
    }
}

+ (NSString *)getAPPID
{
    return [SSKeychain passwordForService:service account:APPIDName];
}

+ (void)setAPPID:(NSString *)appid;
{
    if ([KeyChainManager getAPPID] == nil) {
        [SSKeychain setPassword:APPIDName forService:service account:appid];
    }
}

@end
