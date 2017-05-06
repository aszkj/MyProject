//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "CloudBuyerMoneyPasswordSaveRequest.h"

@implementation CloudBuyerMoneyPasswordSaveRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:self.api_new_password forKey:@"new_password"];
	[self.queryParameters setValue:self.api_mobile_verify_code forKey:@"mobile_verify_code"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return CloudBuyerMoneyPasswordSaveResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/cloud/buyer/money/password/save",self.baseUrl];
    return url;
}

@end
