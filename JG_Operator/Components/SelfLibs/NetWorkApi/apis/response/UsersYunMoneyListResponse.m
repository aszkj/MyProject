//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersYunMoneyListResponse.h"

@implementation UsersYunMoneyListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"userYunMoneyBO":@"UserYunMoneyBO",
			@"userYunMoneyCount":@"userYunMoneyCount",
			@"listMap":@"listMap"
             };
}

+(NSValueTransformer *) userYunMoneyBOTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[UserYunMoneyBO class]];
}
@end
