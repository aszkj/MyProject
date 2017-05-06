//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopTradeReturnViewRequest.h"

@implementation ShopTradeReturnViewRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_id stringValue] forKey:@"id"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return ShopTradeReturnViewResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/shop/trade/return/view",self.baseUrl];
    return url;
}

@end
