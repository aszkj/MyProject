//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "RegisterUsersCreateRequest.h"

@implementation RegisterUsersCreateRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:self.api_nickname forKey:@"nickname"];
	[self.queryParameters setValue:self.api_verifyCode forKey:@"verifyCode"];
	[self.queryParameters setValue:self.api_mobile forKey:@"mobile"];
	[self.queryParameters setValue:self.api_password forKey:@"password"];
	[self.queryParameters setValue:self.api_invitationCode forKey:@"invitationCode"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return RegisterUsersCreateResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/register/users/create",self.baseUrl];
    return url;
}

@end
