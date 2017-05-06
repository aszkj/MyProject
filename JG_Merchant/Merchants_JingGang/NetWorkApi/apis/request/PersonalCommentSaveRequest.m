//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PersonalCommentSaveRequest.h"

@implementation PersonalCommentSaveRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_orderId stringValue] forKey:@"orderId"];
	[self.queryParameters setValue:self.api_content forKey:@"content"];
	[self.queryParameters setValue:[self.api_evaluationAverage stringValue] forKey:@"evaluationAverage"];
	[self.queryParameters setValue:self.api_photo forKey:@"photo"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return PersonalCommentSaveResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/personal/comment/save",self.baseUrl];
    return url;
}

@end
