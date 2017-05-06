//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OOrderOnlineListRequest.h"

@implementation OOrderOnlineListRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_storeId stringValue] forKey:@"storeId"];
	[self.queryParameters setValue:[self.api_orderStatus stringValue] forKey:@"orderStatus"];
	[self.queryParameters setValue:[self.api_orderType stringValue] forKey:@"orderType"];
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
    return OOrderOnlineListResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/o/order_online/list",self.baseUrl];
    return url;
}

@end
