//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OrderForfDetail.h"

@implementation OrderForfDetail
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"orderId":@"orderId",
			@"orderStatus":@"orderStatus",
			@"receiverMobile":@"receiverMobile",
			@"storeId":@"storeId",
			@"receiverName":@"receiverName",
			@"receiverArea":@"receiverArea",
			@"receiverAreaInfo":@"receiverAreaInfo",
			@"couponAmount":@"couponAmount",
			@"addTime":@"addTime",
			@"shipPrice":@"shipPrice",
			@"orderFormList":@"orderFormList",
			@"storeName":@"storeName",
			@"goodsAmount":@"goodsAmount",
			@"expressCompanyId":@"expressCompanyId",
			@"shipCode":@"shipCode",
			@"totalPrice":@"totalPrice",
			@"price":@"price"
             };
}

+(NSValueTransformer *) orderFormListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[SelfOrder class]];
}
@end
