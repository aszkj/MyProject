//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SnsConsultingAddRequest.h"

@implementation SnsConsultingAddRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_id stringValue] forKey:@"id"];
	[self.queryParameters setValue:[self.api_expertsUserId stringValue] forKey:@"expertsUserId"];
	[self.queryParameters setValue:self.api_title forKey:@"title"];
	[self.queryParameters setValue:self.api_images forKey:@"images"];
	[self.queryParameters setValue:self.api_content forKey:@"content"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return SnsConsultingAddResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/sns/consulting/add",self.baseUrl];
    return url;
}

@end
