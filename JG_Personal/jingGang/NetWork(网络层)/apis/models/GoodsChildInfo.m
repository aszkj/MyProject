//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GoodsChildInfo.h"

@implementation GoodsChildInfo
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"orderId":@"orderId",
			@"orderGoodsInfo":@"orderGoodsInfo"
             };
}

+(NSValueTransformer *) orderGoodsInfoTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GoodsInfo class]];
}
@end
