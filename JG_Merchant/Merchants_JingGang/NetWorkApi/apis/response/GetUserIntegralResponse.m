//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GetUserIntegralResponse.h"

@implementation GetUserIntegralResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"customer":@"customer",
			@"integral":@"integral"
             };
}

+(NSValueTransformer *) customerTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[UserCustomer class]];
}
+(NSValueTransformer *) integralTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[UserIntegral class]];
}
@end
