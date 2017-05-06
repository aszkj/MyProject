//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "BindingRegisterRequest.h"

@implementation BindingRegisterRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:self.api_mobile forKey:@"mobile"];
	[self.queryParameters setValue:self.api_nickName forKey:@"nickName"];
	[self.queryParameters setValue:self.api_password forKey:@"password"];
	[self.queryParameters setValue:self.api_InvitationCode forKey:@"InvitationCode"];
	[self.queryParameters setValue:self.api_openId forKey:@"openId"];
	[self.queryParameters setValue:self.api_unionId forKey:@"unionId"];
	[self.queryParameters setValue:self.api_token forKey:@"token"];
	[self.queryParameters setValue:[self.api_type stringValue] forKey:@"type"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return BindingRegisterResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/binding/register",self.baseUrl];
    return url;
}

@end
