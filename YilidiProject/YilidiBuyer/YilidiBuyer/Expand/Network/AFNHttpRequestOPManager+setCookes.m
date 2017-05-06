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
const void *cookiesKey = @"cookiesKey";

@implementation AFNHttpRequestOPManager (setCookes)

#pragma mark ---------------------Public Method------------------------------
+ (void)setSessionIdCookie {
    
    if (SESSIONID) {
        [[self class] setCookiesValue:SESSIONID forKey:YiLiDiSessionID];
    }
}

+ (void)cacheCookieAfterRequestWithResponse:(NSHTTPURLResponse *)response {
    NSString *sessionIdCookieStr = [[self class] _sessionIdCookieValueInResponse:response];
    if (sessionIdCookieStr) {
        [kUserDefaults setObject:sessionIdCookieStr forKey:YiLiDiSessionID];
        [kUserDefaults synchronize];
    }
}

+ (void)clearSessionIdCookie {
    
    if (SESSIONID) {
        [kUserDefaults setObject:nil forKey:YiLiDiSessionID];
        [kUserDefaults synchronize];
    }
}


#pragma mark ---------------------Private Method------------------------------
+ (NSHTTPCookie *)_getCookieWithCookieValue:(NSString *)cookieValue cookieKey:(NSString *)cookieKey
{
#warning 谨记设置cookie域名一定要设置，，否则麻痹真几把坑，，
    NSDictionary *cookieDic = [NSDictionary dictionaryWithObjectsAndKeys:cookieKey, NSHTTPCookieName,
                               cookieValue, NSHTTPCookieValue,
                               @"/", NSHTTPCookiePath,
                               ServerDomain, NSHTTPCookieDomain,
                               nil];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieDic];
    return cookie;
}

+ (void)_setCookies:(NSArray *)cookies
{
    NSDictionary *dictCookies = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    [[[[self class] sharedManager] requestSerializer] setValue:[dictCookies objectForKey:@"Cookie"]  forHTTPHeaderField:@"Cookie"];
}

+ (void)setCookiesValue:(NSString *)cookieValue forKey:(NSString *)cookieKey
{
    if (isEmpty(cookieValue)) {
        JLog(@"空cookie key---%@",cookieKey);
        return;
    }
    NSHTTPCookie *cookie = [self _getCookieWithCookieValue:cookieValue cookieKey:cookieKey];
    
    [self _setCookies:@[cookie]];
    
}

+ (NSString *)_sessionIdCookieValueInResponse:(NSHTTPURLResponse *)response {
    
    NSString *headerSetCookieStr = response.allHeaderFields[@"Set-Cookie"];
    [kUserDefaults setObject:headerSetCookieStr forKey:KSetCookieKey];
    [kUserDefaults synchronize];
    NSString *seperatedStr = [YiLiDiSessionID stringByAppendingString:@"="];
    NSArray *headerArrs = [headerSetCookieStr componentsSeparatedByString:seperatedStr];
    return headerArrs.lastObject;
}




@end
