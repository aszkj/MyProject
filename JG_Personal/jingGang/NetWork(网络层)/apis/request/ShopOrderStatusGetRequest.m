//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopOrderStatusGetRequest.h"

@implementation ShopOrderStatusGetRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_orderId stringValue] forKey:@"orderId"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return ShopOrderStatusGetResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/shop/order_status/get",self.baseUrl];
    return url;
}

@end
