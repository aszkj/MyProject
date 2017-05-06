//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "BindingMobileRequest.h"

@implementation BindingMobileRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:self.api_mobile forKey:@"mobile"];
	[self.queryParameters setValue:self.api_code forKey:@"code"];
	[self.queryParameters setValue:self.api_openId forKey:@"openId"];
	[self.queryParameters setValue:[self.api_type stringValue] forKey:@"type"];
	[self.queryParameters setValue:self.api_token forKey:@"token"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return BindingMobileResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/binding/mobile",self.baseUrl];
    return url;
}

@end
