//
//  IRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "NSString+RegexpReplace.h"
#define PATTERN  @"(\\{.+?\\})"


@implementation AbstractRequest

- (instancetype) init : (NSString *) token {
    self = [super init];
    
    //网络环境，测试环境
    //    self.netType = NetWork_Inline;
    //网络环境，如果是正式api写下面的
//     self.netType = NetWork_Online;
    //开发环境
    self.netType = NetWork_Develop;
    
    if (self.netType == NetWork_Online) {
        self.baseUrl = @"http://api.jgyes.com";
    }else if (self.netType == NetWork_Inline){
        self.baseUrl = @"http://api.jgclub.cn";
    }else{
        self.baseUrl = @"http://api.jgyes.cn";
//        self.baseUrl = @"http://192.168.2.132:8070";
    }
    self.baseUrl = @"http://api.jgyes.cn";
//    self.baseUrl = @"http://192.168.2.227:8083";


    self.headers = [NSMutableDictionary dictionary];
    self.queryParameters = [NSMutableDictionary dictionary];
    self.pathParameters = [NSMutableDictionary dictionary];
    self.accessToken = token;
    self.url = self.getApiUrl;
    self.responseClazz = self.getResponseClazz;
    return self;
}


- (NSString *) getToken
{
    return  self.accessToken;
}

- (Class) getResponseClazz
{
    return self.responseClazz;
}
- (NSString *) getApiUrl
{
    return self.url;
}

- (void) setHeader:(NSString *) key value:(NSString *) value{
    [self.headers setValue:value forKey:key];
}
- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    return self.queryParameters;
}
- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}
- (NSString *) getUrl
{
    NSString *apiUrl = [self getApiUrl];
    NSString *url = [self expandPath:apiUrl withURIVariableDict:self.getPathParameters];
    return url;
    
}

- (NSString*)expandPath:(NSString*)path withURIVariablesArray:(NSArray*)URIVariables {
    
    NSError *error = NULL;
    // Match all {...} in the path
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:PATTERN
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (nil != error) {
        NSLog(@"Regular expression failed with reason:%@", error);
        
        // TODO handle regular expresssion errors
    }
    
    NSString *expandedPath =
    [path stringByReplacingMatches:regex
                           options:0
                             range:NSMakeRange(0, [path length])
           withTransformationBlock:^NSString *(NSString *stringToReplace, NSUInteger index, BOOL *stop) {
               // Get the replacement string from collected var args
               if (index >= [URIVariables count]) {
                   NSLog(@"Warning, variable:%@ not found in var args, will not expand", stringToReplace);
                   return stringToReplace;
               }
               
               // URL encode the replacement string
               return  AFPercentEscapedQueryStringPairMemberFromStringWithEncoding([URIVariables objectAtIndex:index],
                                                                                   NSUTF8StringEncoding);
           }];
    
    //NSLog(@"Path:%@ Var args:%@ Expanded:%@", path, replacements, expandedPath);
    return expandedPath;  
}
// Expand a path using a dictonary of replacement variables
- (NSString*)expandPath:(NSString*)path withURIVariableDict:(NSDictionary*)URIVariables {
    
    NSError *error = NULL;
    // Match all {...} in the path
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:PATTERN
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (nil != error) {
        NSLog(@"Regular expression failed with reason:%@", error);
        
        // TODO handle regular expresssion errors
    }
    
    NSString *expandedPath =
    [path stringByReplacingMatches:regex
                           options:0 range:NSMakeRange(0, [path length])
           withTransformationBlock:^NSString *(NSString *stringToReplace, NSUInteger index, BOOL *stop) {
               //NSLog(@"Find replacement for:%@", stringToReplace);
               
               // Get the replacement string from the dictonary
               NSString *replacement = [URIVariables valueForKey:[stringToReplace substringWithRange:NSMakeRange(1, stringToReplace.length - 2)]];
               if (nil == replacement) {
                   NSLog(@"Warning, variable:%@ not found in dictonary, will not expand", stringToReplace);
                   return stringToReplace;
               }
               
               // URL encode the replacement string
               return AFPercentEscapedQueryStringPairMemberFromStringWithEncoding(replacement, NSUTF8StringEncoding);
           }];
    
    //NSLog(@"Path:%@ Dict:%@ Expanded:%@", path, URIVariables, expandedPath);
    return expandedPath;
}

static NSString * AFPercentEscapedQueryStringPairMemberFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
    static NSString * const kAFCharactersToBeEscaped = @":/?&=;+!@#$()~";
    static NSString * const kAFCharactersToLeaveUnescaped = @"[].";
    
	return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, (__bridge CFStringRef)kAFCharactersToLeaveUnescaped, (__bridge CFStringRef)kAFCharactersToBeEscaped, CFStringConvertNSStringEncodingToEncoding(encoding));
}

@end
