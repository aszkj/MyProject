//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ReportAddRequest.h"

@implementation ReportAddRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_replyId stringValue] forKey:@"replyId"];
	[self.queryParameters setValue:self.api_reportName forKey:@"reportName"];
	[self.queryParameters setValue:self.api_time forKey:@"time"];
	[self.queryParameters setValue:self.api_hospital forKey:@"hospital"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return ReportAddResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/report/add",self.baseUrl];
    return url;
}

@end
