//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SnsInfomationListRequest.h"

@implementation SnsInfomationListRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_classId stringValue] forKey:@"classId"];
//	[self.queryParameters setObject:@(self.baseRoleId) forKey:@"baseRoleId"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return SnsInfomationListResponse.class;
}

- (NSString *) getApiUrl
{
    
    return @"http://api.jgclub.cn/v1/sns/infomation/list";
}

@end
