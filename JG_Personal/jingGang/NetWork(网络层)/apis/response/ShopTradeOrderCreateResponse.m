//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopTradeOrderCreateResponse.h"

@implementation ShopTradeOrderCreateResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"order":@"order",
			@"totalPrice":@"totalPrice"
             };
}

+(NSValueTransformer *) orderTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OrderForm class]];
}
@end
