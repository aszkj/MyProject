//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersCustomerUpdateRequest.h"

@implementation UsersCustomerUpdateRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:self.api_nickname forKey:@"nickname"];
	[self.queryParameters setValue:self.api_name forKey:@"name"];
	[self.queryParameters setValue:[self.api_height stringValue] forKey:@"height"];
	[self.queryParameters setValue:[self.api_weight stringValue] forKey:@"weight"];
	[self.queryParameters setValue:[self.api_sex stringValue] forKey:@"sex"];
	[self.queryParameters setValue:self.api_mobile forKey:@"mobile"];
	[self.queryParameters setValue:self.api_birthDate forKey:@"birthDate"];
	[self.queryParameters setValue:self.api_email forKey:@"email"];
	[self.queryParameters setValue:self.api_headImgPath forKey:@"headImgPath"];
	[self.queryParameters setValue:self.api_allergHistory forKey:@"allergHistory"];
	[self.queryParameters setValue:self.api_transHistory forKey:@"transHistory"];
	[self.queryParameters setValue:self.api_transGenetic forKey:@"transGenetic"];
	[self.queryParameters setValue:self.api_blood forKey:@"blood"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return UsersCustomerUpdateResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/users/customer/update",self.baseUrl];
    return url;
}

@end
