//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SelfEvaluateAddSaveRequest.h"

@implementation SelfEvaluateAddSaveRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_evalId stringValue] forKey:@"evalId"];
	[self.queryParameters setValue:self.api_evaluateInfo forKey:@"evaluateInfo"];
	[self.queryParameters setValue:self.api_imgPath forKey:@"imgPath"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return SelfEvaluateAddSaveResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/self/evaluate_add/save",self.baseUrl];
    return url;
}

@end
