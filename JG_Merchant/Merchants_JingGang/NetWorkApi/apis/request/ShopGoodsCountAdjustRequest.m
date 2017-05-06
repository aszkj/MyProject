//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopGoodsCountAdjustRequest.h"

@implementation ShopGoodsCountAdjustRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_gcId stringValue] forKey:@"gcId"];
	[self.queryParameters setValue:[self.api_count stringValue] forKey:@"count"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return ShopGoodsCountAdjustResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/shop/goods_count/adjust",self.baseUrl];
    return url;
}

@end
