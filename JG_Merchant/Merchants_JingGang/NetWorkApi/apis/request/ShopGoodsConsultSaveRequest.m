//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopGoodsConsultSaveRequest.h"

@implementation ShopGoodsConsultSaveRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_goodsId stringValue] forKey:@"goodsId"];
	[self.queryParameters setValue:self.api_content forKey:@"content"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return ShopGoodsConsultSaveResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/shop/goods_consult/save",self.baseUrl];
    return url;
}

@end
