//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UserCustomerSavefirstRequest.h"

@implementation UserCustomerSavefirstRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_height stringValue] forKey:@"height"];
	[self.queryParameters setValue:[self.api_weight stringValue] forKey:@"weight"];
	[self.queryParameters setValue:[self.api_sex stringValue] forKey:@"sex"];
	[self.queryParameters setValue:self.api_birthDate forKey:@"birthDate"];
	[self.queryParameters setValue:self.api_paddress forKey:@"paddress"];
	[self.queryParameters setValue:self.api_address forKey:@"address"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return UserCustomerSavefirstResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/user/customer/savefirst",self.baseUrl];
    return url;
}

@end
