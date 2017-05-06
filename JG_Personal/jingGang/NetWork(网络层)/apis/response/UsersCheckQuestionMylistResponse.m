//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersCheckQuestionMylistResponse.h"

@implementation UsersCheckQuestionMylistResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"circle":@"circle",
			@"apiId":@"id",
			@"resultname":@"resultname",
			@"createby":@"createby",
			@"createtime":@"createtime",
			@"hospital":@"hospital",
			@"status":@"status",
			@"result":@"result"
             };
}

+(NSValueTransformer *) circleTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CheckQuestion class]];
}
@end
