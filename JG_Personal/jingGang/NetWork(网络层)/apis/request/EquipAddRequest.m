//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "EquipAddRequest.h"

@implementation EquipAddRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_stepNumber stringValue] forKey:@"stepNumber"];
	[self.queryParameters setValue:[self.api_heigth stringValue] forKey:@"heigth"];
	[self.queryParameters setValue:[self.api_weight stringValue] forKey:@"weight"];
	[self.queryParameters setValue:self.api_recordDate forKey:@"recordDate"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return EquipAddResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/equip/add",self.baseUrl];
    return url;
}

@end
