//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PersonalAllCityListRequest.h"

@implementation PersonalAllCityListRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return PersonalAllCityListResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/personal/all_city/list",self.baseUrl];
    return url;
}

@end
