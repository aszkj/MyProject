//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopCartAddRequest.h"

@implementation ShopCartAddRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_goodId stringValue] forKey:@"goodId"];
	[self.queryParameters setValue:[self.api_count stringValue] forKey:@"count"];
	[self.queryParameters setValue:self.api_gsp forKey:@"gsp"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return ShopCartAddResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/shop/cart/add",self.baseUrl];
    return url;
}

@end
