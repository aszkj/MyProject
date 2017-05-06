//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "EquipSleepQueryWeekByMonRequest.h"

@implementation EquipSleepQueryWeekByMonRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:self.api_startDateStr forKey:@"startDateStr"];
	[self.queryParameters setValue:self.api_endDateStr forKey:@"endDateStr"];
	[self.queryParameters setValue:[self.api_parmType stringValue] forKey:@"parmType"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return EquipSleepQueryWeekByMonResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/equip/sleep/queryWeekByMon",self.baseUrl];
    return url;
}

@end
