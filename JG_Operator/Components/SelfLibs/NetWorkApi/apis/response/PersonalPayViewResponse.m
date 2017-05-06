//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PersonalPayViewResponse.h"

@implementation PersonalPayViewResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"order":@"order"
             };
}

+(NSValueTransformer *) orderTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupOrder class]];
}
@end
