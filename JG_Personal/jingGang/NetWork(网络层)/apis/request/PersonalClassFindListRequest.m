//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PersonalClassFindListRequest.h"

@implementation PersonalClassFindListRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_classId stringValue] forKey:@"classId"];
	[self.queryParameters setValue:[self.api_cityId stringValue] forKey:@"cityId"];
	[self.queryParameters setValue:[self.api_areaId stringValue] forKey:@"areaId"];
	[self.queryParameters setValue:[self.api_distance stringValue] forKey:@"distance"];
	[self.queryParameters setValue:[self.api_orderType stringValue] forKey:@"orderType"];
	[self.queryParameters setValue:[self.api_storeLat stringValue] forKey:@"storeLat"];
	[self.queryParameters setValue:[self.api_storeLon stringValue] forKey:@"storeLon"];
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
    return PersonalClassFindListResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/personal/class_find/list",self.baseUrl];
    return url;
}

@end
