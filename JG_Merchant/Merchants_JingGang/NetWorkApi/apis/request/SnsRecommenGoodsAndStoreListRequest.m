//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SnsRecommenGoodsAndStoreListRequest.h"

@implementation SnsRecommenGoodsAndStoreListRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_groupId stringValue] forKey:@"groupId"];
	[self.queryParameters setValue:[self.api_storeLon stringValue] forKey:@"storeLon"];
	[self.queryParameters setValue:[self.api_storeLat stringValue] forKey:@"storeLat"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return SnsRecommenGoodsAndStoreListResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/sns/recommen_goods_and_store/list",self.baseUrl];
    return url;
}

@end
