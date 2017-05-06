//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "CloudBuyerPaymetRequest.h"

@implementation CloudBuyerPaymetRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_id stringValue] forKey:@"id"];
	[self.queryParameters setValue:self.api_pdAmount forKey:@"pdAmount"];
	[self.queryParameters setValue:self.api_pdPayment forKey:@"pdPayment"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return CloudBuyerPaymetResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/cloud/buyer/paymet",self.baseUrl];
    return url;
}

@end
