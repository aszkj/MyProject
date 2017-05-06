//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersCheckHistoryResponse.h"

@implementation UsersCheckHistoryResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"checkResults":@"checkResults",
			@"totalCount":@"totalCount"
             };
}

+(NSValueTransformer *) checkResultsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CheckResultHistory class]];
}
@end
