//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SnsArticleArticleClassRequest.h"

@implementation SnsArticleArticleClassRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_parentClassId stringValue] forKey:@"parentClassId"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return SnsArticleArticleClassResponse.class;
}

- (NSString *) getApiUrl
{
    
    return @"http://api.jgclub.cn/v1/sns/article/article_class";
}

@end
