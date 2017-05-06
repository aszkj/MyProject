//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OrderForm.h"

@implementation OrderForm
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"goodsAmount":@"goodsAmount",
			@"orderForm":@"orderForm",
			@"orderId":@"orderId",
			@"orderStatus":@"orderStatus",
			@"storeName":@"storeName",
			@"storeId":@"storeId",
			@"totalPrice":@"totalPrice",
			@"infoList":@"infoList"
             };
}

+(NSValueTransformer *) infoListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GoodsInfo class]];
}
@end
