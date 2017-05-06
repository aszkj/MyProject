//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopExpressTransViewRequest.h"

@implementation ShopExpressTransViewRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:self.api_expressCode forKey:@"expressCode"];
	[self.queryParameters setValue:[self.api_expressCompanyId stringValue] forKey:@"expressCompanyId"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return ShopExpressTransViewResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/shop/express/trans/view",self.baseUrl];
    return url;
}

@end
