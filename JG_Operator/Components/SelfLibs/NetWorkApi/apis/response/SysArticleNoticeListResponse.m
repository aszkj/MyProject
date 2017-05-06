//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SysArticleNoticeListResponse.h"

@implementation SysArticleNoticeListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"articles":@"articles",
			@"totalCount":@"totalCount"
             };
}

+(NSValueTransformer *) articlesTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ArticleBO class]];
}
@end
