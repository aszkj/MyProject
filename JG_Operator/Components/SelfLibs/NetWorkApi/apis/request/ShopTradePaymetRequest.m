//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopTradePaymetRequest.h"

@implementation ShopTradePaymetRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:self.api_paymentType forKey:@"paymentType"];
	[self.queryParameters setValue:[self.api_mainOrderId stringValue] forKey:@"mainOrderId"];
	[self.queryParameters setValue:[self.api_isUserMoneyPaymet stringValue] forKey:@"isUserMoneyPaymet"];
	[self.queryParameters setValue:self.api_paymetPassword forKey:@"paymetPassword"];
	[self.queryParameters setValue:[self.api_type stringValue] forKey:@"type"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return ShopTradePaymetResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/shop/trade/paymet",self.baseUrl];
    return url;
}

@end
