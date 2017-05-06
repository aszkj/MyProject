//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "EquipDayQueryByRangeRequest.h"

@implementation EquipDayQueryByRangeRequest



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
    return EquipDayQueryByRangeResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/equip/day/queryByRange",self.baseUrl];
    return url;
}

@end
