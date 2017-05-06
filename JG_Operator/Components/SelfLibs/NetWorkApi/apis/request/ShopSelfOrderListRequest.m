//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopSelfOrderListRequest.h"

@implementation ShopSelfOrderListRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:self.api_orderStatus forKey:@"orderStatus"];
	[self.queryParameters setValue:self.api_beginTime forKey:@"beginTime"];
	[self.queryParameters setValue:self.api_endTime forKey:@"endTime"];
	[self.queryParameters setValue:self.api_orderId forKey:@"orderId"];
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
    return ShopSelfOrderListResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/shop/self/order/list",self.baseUrl];
    return url;
}

@end
