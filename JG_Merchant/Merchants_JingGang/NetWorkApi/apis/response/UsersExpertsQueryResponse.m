//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersExpertsQueryResponse.h"

@implementation UsersExpertsQueryResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"experts":@"experts",
			@"totalCount":@"totalCount"
             };
}

+(NSValueTransformer *) expertsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[UserExperts class]];
}
@end
