//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OperatorPasswordUpdateRequest.h"

@implementation OperatorPasswordUpdateRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:self.api_oldPassword forKey:@"oldPassword"];
	[self.queryParameters setValue:self.api_newPassword forKey:@"newPassword"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return OperatorPasswordUpdateResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/operator/password/update",self.baseUrl];
    return url;
}

@end
