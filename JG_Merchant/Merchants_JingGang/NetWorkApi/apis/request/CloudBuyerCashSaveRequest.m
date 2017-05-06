//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "CloudBuyerCashSaveRequest.h"

@implementation CloudBuyerCashSaveRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:self.api_cashAmount forKey:@"cashAmount"];
	[self.queryParameters setValue:self.api_cashPayment forKey:@"cashPayment"];
	[self.queryParameters setValue:self.api_cashUserName forKey:@"cashUserName"];
	[self.queryParameters setValue:self.api_cashBank forKey:@"cashBank"];
	[self.queryParameters setValue:self.api_cashAccount forKey:@"cashAccount"];
	[self.queryParameters setValue:self.api_cashPassword forKey:@"cashPassword"];
	[self.queryParameters setValue:self.api_cashInfo forKey:@"cashInfo"];
	[self.queryParameters setValue:[self.api_userType stringValue] forKey:@"userType"];
	[self.queryParameters setValue:self.api_cashSubbranch forKey:@"cashSubbranch"];
	[self.queryParameters setValue:[self.api_cashRelation stringValue] forKey:@"cashRelation"];
	[self.queryParameters setValue:[self.api_cashId stringValue] forKey:@"cashId"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return CloudBuyerCashSaveResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/cloud/buyer/cash/save",self.baseUrl];
    return url;
}

@end
