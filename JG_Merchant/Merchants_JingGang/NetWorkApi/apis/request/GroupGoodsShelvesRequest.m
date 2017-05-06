//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GroupGoodsShelvesRequest.h"

@implementation GroupGoodsShelvesRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_goodsId stringValue] forKey:@"goodsId"];
	[self.queryParameters setValue:[self.api_goodsStatus stringValue] forKey:@"goodsStatus"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return GroupGoodsShelvesResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/group/goods/shelves",self.baseUrl];
    return url;
}

@end
