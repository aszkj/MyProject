//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersPayPasswordUpdateRequest.h"

@implementation UsersPayPasswordUpdateRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:self.api_mobile forKey:@"mobile"];
	[self.queryParameters setValue:self.api_code forKey:@"code"];
	[self.queryParameters setValue:self.api_password forKey:@"password"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return UsersPayPasswordUpdateResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/users/pay_password/update",self.baseUrl];
    return url;
}

@end
