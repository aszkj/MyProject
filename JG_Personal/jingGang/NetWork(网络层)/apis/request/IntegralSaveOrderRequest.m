//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IntegralSaveOrderRequest.h"

@implementation IntegralSaveOrderRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:self.api_goodsJson forKey:@"goodsJson"];
	[self.queryParameters setValue:[self.api_addressId stringValue] forKey:@"addressId"];
	[self.queryParameters setValue:self.api_trueName forKey:@"trueName"];
	[self.queryParameters setValue:[self.api_areaId stringValue] forKey:@"areaId"];
	[self.queryParameters setValue:self.api_zip forKey:@"zip"];
	[self.queryParameters setValue:self.api_areaInfo forKey:@"areaInfo"];
	[self.queryParameters setValue:self.api_mobile forKey:@"mobile"];
	[self.queryParameters setValue:self.api_telephone forKey:@"telephone"];
	[self.queryParameters setValue:self.api_igoMsg forKey:@"igoMsg"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return IntegralSaveOrderResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/integral/saveOrder",self.baseUrl];
    return url;
}

@end
