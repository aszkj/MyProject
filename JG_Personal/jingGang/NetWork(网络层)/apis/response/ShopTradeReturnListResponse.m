//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopTradeReturnListResponse.h"

@implementation ShopTradeReturnListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"list":@"list",
			@"currentPage":@"current_page",
			@"totalPage":@"total_page",
			@"totalRecord":@"total_record"
             };
}

+(NSValueTransformer *) listTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ReturnGoodsLog class]];
}
@end
