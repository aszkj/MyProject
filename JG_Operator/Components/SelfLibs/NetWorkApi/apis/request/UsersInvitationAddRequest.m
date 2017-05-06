//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersInvitationAddRequest.h"

@implementation UsersInvitationAddRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_circleId stringValue] forKey:@"circleId"];
	[self.queryParameters setValue:self.api_title forKey:@"title"];
	[self.queryParameters setValue:self.api_context forKey:@"context"];
	[self.queryParameters setValue:self.api_images forKey:@"images"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return UsersInvitationAddResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/users/invitation/add",self.baseUrl];
    return url;
}

@end
