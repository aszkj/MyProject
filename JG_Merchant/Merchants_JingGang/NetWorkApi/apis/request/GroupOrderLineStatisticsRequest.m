//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GroupOrderLineStatisticsRequest.h"

@implementation GroupOrderLineStatisticsRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_orderType stringValue] forKey:@"orderType"];
	[self.queryParameters setValue:self.api_startTime forKey:@"startTime"];
	[self.queryParameters setValue:self.api_endTime forKey:@"endTime"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return GroupOrderLineStatisticsResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/group/order_line/statistics",self.baseUrl];
    return url;
}

@end
