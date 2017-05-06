//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopTradeReturnCancelRequest.h"

@implementation ShopTradeReturnCancelRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_orderId stringValue] forKey:@"orderId"];
	[self.queryParameters setValue:[self.api_goodsId stringValue] forKey:@"goodsId"];
	[self.queryParameters setValue:self.api_goodsGspIds forKey:@"goodsGspIds"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return ShopTradeReturnCancelResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/shop/trade/return/cancel",self.baseUrl];
    return url;
}

@end
