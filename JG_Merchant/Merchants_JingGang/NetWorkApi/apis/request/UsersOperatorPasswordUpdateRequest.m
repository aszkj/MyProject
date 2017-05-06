//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersOperatorPasswordUpdateRequest.h"

@implementation UsersOperatorPasswordUpdateRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:self.api_odlPassword forKey:@"odlPassword"];
	[self.queryParameters setValue:self.api_newPassword forKey:@"newPassword"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return UsersOperatorPasswordUpdateResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/users/operator_password/update",self.baseUrl];
    return url;
}

@end
