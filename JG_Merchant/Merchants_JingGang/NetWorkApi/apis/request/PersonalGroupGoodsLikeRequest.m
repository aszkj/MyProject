//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PersonalGroupGoodsLikeRequest.h"

@implementation PersonalGroupGoodsLikeRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_gId stringValue] forKey:@"gId"];
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
    return PersonalGroupGoodsLikeResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/personal/group_goods/like",self.baseUrl];
    return url;
}

@end
