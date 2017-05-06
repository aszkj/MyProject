//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PersonalOrderPayResponse.h"

@implementation PersonalOrderPayResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"isCompletePay":@"isCompletePay",
			@"paymetType":@"paymetType",
			@"paySignature":@"paySignature",
			@"weiXinPaymet":@"weiXinPaymet",
			@"orderStatus":@"orderStatus"
             };
}

+(NSValueTransformer *) weiXinPaymetTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[WeiXinPaymet class]];
}
@end