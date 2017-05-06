//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersInvitationDetailsRequest.h"

@implementation UsersInvitationDetailsRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_invnId stringValue] forKey:@"invnId"];
	[self.queryParameters setValue:[self.api_jgyes_app stringValue] forKey:@"jgyes_app"];
	[self.queryParameters setValue:self.api_invitationCode forKey:@"invitationCode"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return UsersInvitationDetailsResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/users/invitation/details",self.baseUrl];
    return url;
}

@end
