//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopCartAddressSaveRequest.h"

@implementation ShopCartAddressSaveRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_id stringValue] forKey:@"id"];
	[self.queryParameters setValue:[self.api_defaultValue stringValue] forKey:@"defaultValue"];
	[self.queryParameters setValue:self.api_trueName forKey:@"trueName"];
	[self.queryParameters setValue:self.api_telephone forKey:@"telephone"];
	[self.queryParameters setValue:self.api_mobile forKey:@"mobile"];
	[self.queryParameters setValue:[self.api_areaId stringValue] forKey:@"areaId"];
	[self.queryParameters setValue:self.api_areaInfo forKey:@"areaInfo"];
	[self.queryParameters setValue:self.api_zip forKey:@"zip"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return ShopCartAddressSaveResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/shop/cart_address/save",self.baseUrl];
    return url;
}

@end
