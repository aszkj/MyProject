//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SelfOrder.h"

@implementation SelfOrder
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"orderId":@"orderId",
			@"childOrderDetail":@"childOrderDetail",
			@"orderStatus":@"orderStatus",
			@"shipPrice":@"shipPrice",
			@"goods":@"goods",
			@"receiverName":@"receiverName",
			@"receiverArea":@"receiverArea",
			@"receiverAreaInfo":@"receiverAreaInfo",
			@"goodsInfos":@"goodsInfos",
			@"goodsInfo":@"goodsInfo",
			@"totalPrice":@"totalPrice",
			@"receiverMobile":@"receiverMobile",
			@"storeId":@"storeId",
			@"storeName":@"storeName",
			@"couponAmount":@"couponAmount",
			@"addTime":@"addTime",
			@"goodsAmount":@"goodsAmount",
			@"expressCompanyId":@"expressCompanyId",
			@"shipCode":@"shipCode",
			@"orderForm":@"orderForm",
			@"payWay":@"payWay"
             };
}

+(NSValueTransformer *) goodsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Goods class]];
}
+(NSValueTransformer *) goodsInfosTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GoodsInfo class]];
}
@end
