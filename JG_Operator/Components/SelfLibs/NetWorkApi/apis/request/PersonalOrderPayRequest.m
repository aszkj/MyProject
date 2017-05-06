//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PersonalOrderPayRequest.h"

@implementation PersonalOrderPayRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:self.api_payType forKey:@"payType"];
	[self.queryParameters setValue:[self.api_orderId stringValue] forKey:@"orderId"];
	[self.queryParameters setValue:[self.api_isAvailableBalance stringValue] forKey:@"isAvailableBalance"];
	[self.queryParameters setValue:self.api_paymentPassword forKey:@"paymentPassword"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return PersonalOrderPayResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/personal/order/pay",self.baseUrl];
    return url;
}

@end
