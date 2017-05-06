//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SalePromotionActivityAdMainInfoResponse.h"

@implementation SalePromotionActivityAdMainInfoResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"activityHotSaleApiBO":@"activityHotSaleApiBO"
             };
}

+(NSValueTransformer *) activityHotSaleApiBOTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ActivityHotSaleApiBO class]];
}
@end
