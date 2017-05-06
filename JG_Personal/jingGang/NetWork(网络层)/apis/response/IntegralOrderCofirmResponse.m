//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IntegralOrderCofirmResponse.h"

@implementation IntegralOrderCofirmResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"computeOrderBO":@"computeOrderBO",
			@"orderBO":@"orderBO",
			@"addressList":@"addressList",
			@"orderList":@"orderList",
			@"integralList":@"integralList",
			@"totalCount":@"totalCount",
			@"integralDetails":@"integralDetails",
			@"exchangeStatus":@"exchangeStatus",
			@"details":@"details",
			@"integralGoodsList":@"integralGoodsList"
             };
}

+(NSValueTransformer *) computeOrderBOTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ComputeOrderBO class]];
}
+(NSValueTransformer *) orderBOTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OrderBO class]];
}
+(NSValueTransformer *) addressListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AddressListBO class]];
}
+(NSValueTransformer *) orderListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OrderListBO class]];
}
+(NSValueTransformer *) integralListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[IntegralListBO class]];
}
+(NSValueTransformer *) integralDetailsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[IntegralGoodsDetails class]];
}
+(NSValueTransformer *) detailsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[IntegralOrderDetails class]];
}
+(NSValueTransformer *) integralGoodsListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[IntegralGoodsDetails class]];
}
@end
