//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "EquipSleepAddRequest.h"

@implementation EquipSleepAddRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_sleepSecond stringValue] forKey:@"sleepSecond"];
	[self.queryParameters setValue:[self.api_deepSleepSecond stringValue] forKey:@"deepSleepSecond"];
	[self.queryParameters setValue:[self.api_shallowSleepSecond stringValue] forKey:@"shallowSleepSecond"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return EquipSleepAddResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/equip/sleep/add",self.baseUrl];
    return url;
}

@end
