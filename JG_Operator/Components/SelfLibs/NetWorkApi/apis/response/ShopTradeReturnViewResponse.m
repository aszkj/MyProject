//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopTradeReturnViewResponse.h"

@implementation ShopTradeReturnViewResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"returnGoodsLog":@"returnGoodsLog"
             };
}

+(NSValueTransformer *) returnGoodsLogTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ReturnGoodsLog class]];
}
@end
