//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersRepylAddRequest.h"

@implementation UsersRepylAddRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_invitationId stringValue] forKey:@"invitationId"];
	[self.queryParameters setValue:[self.api_replyId stringValue] forKey:@"replyId"];
	[self.queryParameters setValue:self.api_content forKey:@"content"];
	[self.queryParameters setValue:self.api_pic forKey:@"pic"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return UsersRepylAddResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/users/repyl/add",self.baseUrl];
    return url;
}

@end
