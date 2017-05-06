//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersExpertsQueryRequest.h"

@implementation UsersExpertsQueryRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_expertsType stringValue] forKey:@"expertsType"];
	[self.queryParameters setValue:self.api_type forKey:@"type"];
	[self.queryParameters setValue:[self.api_pageSize stringValue] forKey:@"pageSize"];
	[self.queryParameters setValue:[self.api_pageNum stringValue] forKey:@"pageNum"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return UsersExpertsQueryResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/users/experts/query",self.baseUrl];
    return url;
}

@end
