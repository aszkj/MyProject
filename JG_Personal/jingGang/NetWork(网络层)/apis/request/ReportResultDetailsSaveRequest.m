//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ReportResultDetailsSaveRequest.h"

@implementation ReportResultDetailsSaveRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:[self.api_replyId stringValue] forKey:@"replyId"];
	[self.queryParameters setValue:[self.api_itemId stringValue] forKey:@"itemId"];
	[self.queryParameters setValue:[self.api_value stringValue] forKey:@"value"];
	[self.queryParameters setValue:[self.api_detailsId stringValue] forKey:@"detailsId"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return ReportResultDetailsSaveResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/report/result_details/save",self.baseUrl];
    return url;
}

@end
