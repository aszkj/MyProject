//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OQueryGroupGoodsListRequest.h"

@implementation OQueryGroupGoodsListRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_storeId stringValue] forKey:@"storeId"];
	[self.queryParameters setValue:[self.api_ggStatus stringValue] forKey:@"ggStatus"];
	[self.queryParameters setValue:[self.api_goodsType stringValue] forKey:@"goodsType"];
	[self.queryParameters setValue:[self.api_pageSize stringValue] forKey:@"pageSize"];
	[self.queryParameters setValue:[self.api_pageNum stringValue] forKey:@"pageNum"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return OQueryGroupGoodsListResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/o/query_group_goods/list",self.baseUrl];
    return url;
}

@end
