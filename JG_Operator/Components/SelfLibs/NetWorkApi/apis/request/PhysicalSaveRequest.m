//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PhysicalSaveRequest.h"

@implementation PhysicalSaveRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_minValue stringValue] forKey:@"minValue"];
	[self.queryParameters setValue:[self.api_maxValue stringValue] forKey:@"maxValue"];
	[self.queryParameters setValue:[self.api_middleValue stringValue] forKey:@"middleValue"];
	[self.queryParameters setValue:[self.api_type stringValue] forKey:@"type"];
	[self.queryParameters setValue:self.api_time forKey:@"time"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return PhysicalSaveResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/physical/save",self.baseUrl];
    return url;
}

@end
