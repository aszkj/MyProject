//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopExpressTransViewResponse.h"

@implementation ShopExpressTransViewResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"trans":@"trans"
             };
}

+(NSValueTransformer *) transTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TransInfo class]];
}
@end
