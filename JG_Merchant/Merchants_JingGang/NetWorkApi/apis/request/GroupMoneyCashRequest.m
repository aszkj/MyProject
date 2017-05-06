//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GroupMoneyCashRequest.h"

@implementation GroupMoneyCashRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_cashAmount stringValue] forKey:@"cashAmount"];
	[self.queryParameters setValue:self.api_cashPayment forKey:@"cashPayment"];
	[self.queryParameters setValue:self.api_cashUserName forKey:@"cashUserName"];
	[self.queryParameters setValue:self.api_cashBank forKey:@"cashBank"];
	[self.queryParameters setValue:self.api_cashAccount forKey:@"cashAccount"];
	[self.queryParameters setValue:self.api_cashPassword forKey:@"cashPassword"];
	[self.queryParameters setValue:self.api_cashInfo forKey:@"cashInfo"];
	[self.queryParameters setValue:[self.api_userType stringValue] forKey:@"userType"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return GroupMoneyCashResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/group/money/cash",self.baseUrl];
    return url;
}

@end
