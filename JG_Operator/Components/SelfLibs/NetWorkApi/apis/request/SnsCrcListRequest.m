//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SnsCrcListRequest.h"

@implementation SnsCrcListRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:self.api_posCode forKey:@"posCode"];
	[self.queryParameters setValue:self.api_timeStamp forKey:@"timeStamp"];
	[self.queryParameters setValue:[self.api_cityId stringValue] forKey:@"cityId"];
	[self.queryParameters setValue:[self.api_lon stringValue] forKey:@"lon"];
	[self.queryParameters setValue:[self.api_lat stringValue] forKey:@"lat"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return SnsCrcListResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/sns/crc/list",self.baseUrl];
    return url;
}

@end
