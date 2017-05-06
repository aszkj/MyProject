//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GroupOrderCartPayRequest.h"

@implementation GroupOrderCartPayRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:self.api_mobile forKey:@"mobile"];
	[self.queryParameters setValue:[self.api_price stringValue] forKey:@"price"];
	[self.queryParameters setValue:self.api_goodsName forKey:@"goodsName"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return GroupOrderCartPayResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/group/order_cart/pay",self.baseUrl];
    return url;
}

@end
