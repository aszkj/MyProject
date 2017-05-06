//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopTradeOrderCreateRequest.h"

@implementation ShopTradeOrderCreateRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_addrId stringValue] forKey:@"addrId"];
	[self.queryParameters setValue:self.api_transportIds forKey:@"transportIds"];
	[self.queryParameters setValue:self.api_msgs forKey:@"msgs"];
	[self.queryParameters setValue:self.api_couponIds forKey:@"couponIds"];
	[self.queryParameters setValue:self.api_integralIds forKey:@"integralIds"];
	[self.queryParameters setValue:self.api_gcIds forKey:@"gcIds"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return ShopTradeOrderCreateResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/shop/trade/order/create",self.baseUrl];
    return url;
}

@end
