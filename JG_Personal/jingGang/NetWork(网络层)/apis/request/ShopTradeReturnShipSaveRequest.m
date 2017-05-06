//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopTradeReturnShipSaveRequest.h"

@implementation ShopTradeReturnShipSaveRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_returnGoodsLogId stringValue] forKey:@"returnGoodsLogId"];
	[self.queryParameters setValue:[self.api_expressId stringValue] forKey:@"expressId"];
	[self.queryParameters setValue:self.api_expressCode forKey:@"expressCode"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return ShopTradeReturnShipSaveResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/shop/trade/return/ship/save",self.baseUrl];
    return url;
}

@end
