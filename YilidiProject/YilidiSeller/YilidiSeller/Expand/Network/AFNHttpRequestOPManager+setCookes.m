//
//  AFNHttpRequestOPManager+setCookes.m
//  YilidiBuyer
//
//  Created by yld on 16/5/24.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "AFNHttpRequestOPManager+setCookes.h"
#import "NSObject+SUIAdditions.h"
#import "GlobleConst.h"
#import "DLRequestUrl.h"
const void *cookiesKey = @"cookiesKey";

@implementation AFNHttpRequestOPManager (setCookes)

+ (void)setCookiesValue:(NSString *)cookieValue forKey:(NSString *)cookieKey
{
    if (isEmpty(cookieValue)) {
        return;
    }
    AFNHttpRequestOPManager *manager = [self sharedManager];
    NSMutableArray *cookies =  [manager sui_getAssociatedObjectWithKey:cookiesKey];
    if (!cookies || !cookies.count) {
        cookies = [NSMutableArray arrayWithCapacity:0];
        [manager sui_setAssociatedRetainObject:cookies key:cookiesKey];
    }
    
    if (cookies.count > 0) {
        BOOL hasThisCookie = NO;
        for (NSHTTPCookie *cookie in cookies) {
            if ([cookieKey isEqualToString:cookie.name]) {
                hasThisCookie = YES;
                break;
            }
        }
        if (hasThisCookie) {
            return;
        }
    }
    
#warning 谨记设置cookie域名一定要设置，，否则麻痹真几把坑，，
    NSDictionary *cookieDic = [NSDictionary dictionaryWithObjectsAndKeys:cookieKey, NSHTTPCookieName,
                                      cookieValue, NSHTTPCookieValue,
                                      @"/", NSHTTPCookiePath,
                                      TestDomain, NSHTTPCookieDomain,
                                      nil];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieDic];
    [cookies addObject:cookie];
    NSDictionary *dictCookies = [NSHTTPCookie requestHeaderFieldsWithCookies:[cookies copy]];
    [[[[self class] sharedManager] requestSerializer] setValue:[dictCookies objectForKey:@"Cookie"]  forHTTPHeaderField:@"Cookie"];
    
    JLog(@"header --- %@", [[[self class] sharedManager] requestSerializer].HTTPRequestHeaders);

}

+ (void)setSessionIdCookie {
    
    if (SESSIONID) {
        [[self class] setCookiesValue:SESSIONID forKey:YiLiDiSessionID];
    }else {
        [[self class] setCookiesValue:UNLOGIN_SESSIONID forKey:YiLiDiSessionID];
    }
}


+ (void)removeCookieForCookieKey:(NSString *)cookieKey {
    
    [kUserDefaults setObject:nil forKey:cookieKey];
    [kUserDefaults synchronize];
    
    AFNHttpRequestOPManager *manager = [self sharedManager];
    NSMutableArray *cookies =  [manager sui_getAssociatedObjectWithKey:cookiesKey];
    if (!cookies || !cookies.count) {
        return;
    }
    NSHTTPCookie *willBeRemovedCookie = nil;
    for (NSHTTPCookie *cookie in cookies) {
        if ([cookieKey isEqualToString:cookie.name]) {
            willBeRemovedCookie = cookie;
            break;
        }
    }
    if (willBeRemovedCookie) {
        [cookies removeObject:willBeRemovedCookie];
        return;
    }

}





@end
