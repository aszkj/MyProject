//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GroupConsumShareListResponse.h"

@implementation GroupConsumShareListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"merchant":@"merchant",
			@"groupOrderList":@"groupOrderList",
			@"groupOrderBO":@"groupOrderBO",
			@"groupGoodsBOs":@"groupGoodsBOs",
			@"groupGoodsDetails":@"groupGoodsDetails",
			@"applyInfo":@"applyInfo",
			@"evaluateList":@"evaluateList",
			@"rebateBO":@"rebateBO",
			@"rebateList":@"rebateList",
			@"totalPrice":@"totalPrice",
			@"orderTotalPriceList":@"orderTotalPriceList",
			@"orderDetailsList":@"orderDetailsList",
			@"storeCustomerList":@"storeCustomerList",
			@"storeAlbumList":@"storeAlbumList",
			@"tradeNo":@"tradeNo",
			@"preCashList":@"preCashList",
			@"groupClassList":@"groupClassList",
			@"areaBOs":@"areaBOs",
			@"classDetails":@"classDetails",
			@"evaluateTotal":@"evaluateTotal",
			@"customerTotal":@"customerTotal",
			@"refundBOs":@"refundBOs",
			@"orderStatus":@"orderStatus",
			@"orderId":@"orderId",
			@"storeAppInfoBo":@"storeAppInfoBo",
			@"storeCheckIn":@"storeCheckIn"
             };
}

+(NSValueTransformer *) merchantTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[StoreIndex class]];
}
+(NSValueTransformer *) groupOrderListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupOrder class]];
}
+(NSValueTransformer *) groupOrderBOTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupOrder class]];
}
+(NSValueTransformer *) groupGoodsBOsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupGoods class]];
}
+(NSValueTransformer *) groupGoodsDetailsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupGoods class]];
}
+(NSValueTransformer *) applyInfoTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[StoreApplyInfo class]];
}
+(NSValueTransformer *) evaluateListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupEvaluates class]];
}
+(NSValueTransformer *) rebateBOTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Rebate class]];
}
+(NSValueTransformer *) rebateListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Rebate class]];
}
+(NSValueTransformer *) orderTotalPriceListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Rebate class]];
}
+(NSValueTransformer *) orderDetailsListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OrderDetails class]];
}
+(NSValueTransformer *) storeCustomerListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[StoreCustomer class]];
}
+(NSValueTransformer *) storeAlbumListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[StoreAlbum class]];
}
+(NSValueTransformer *) preCashListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[UPrepositLog class]];
}
+(NSValueTransformer *) groupClassListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupClass class]];
}
+(NSValueTransformer *) areaBOsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupArea class]];
}
+(NSValueTransformer *) classDetailsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupClass class]];
}
+(NSValueTransformer *) refundBOsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GoodsRefund class]];
}
+(NSValueTransformer *) storeAppInfoBoTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[StoreAppInfo class]];
}
@end
