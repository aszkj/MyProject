//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "RegisterThirdCreateRequest.h"

@implementation RegisterThirdCreateRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:self.api_longName forKey:@"longName"];
	[self.queryParameters setValue:self.api_loginType forKey:@"loginType"];
	[self.queryParameters setValue:self.api_nickName forKey:@"nickName"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return RegisterThirdCreateResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/register/third/create",self.baseUrl];
    return url;
}

@end
