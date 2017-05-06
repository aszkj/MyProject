//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersIntegralListResponse.h"

@implementation UsersIntegralListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"userIntegralDetailBO":@"userIntegralDetailBO",
			@"userIntegralCount":@"userIntegralCount",
			@"integralBalance":@"integralBalance"
             };
}

+(NSValueTransformer *) userIntegralDetailBOTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[UserIntegralDetailBO class]];
}
@end
