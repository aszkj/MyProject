//
//  PropertyListReformer.m
//  jingGang
//
//  Created by thinker on 15/8/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "ShopCenterListReformer.h"
#import "APIManager.h"


@implementation ShopCenterListReformer

NSString * const shopDataKeyName = @"shopDataKeyName";
NSString * const shopDataKeyLogo = @"shopDataKeyLogo";
NSString * const shopDataKeyType = @"shopDataKeyType";

/**
 *  收货的地址的相关键值
 */
NSString * const addressKeyUsrName       = @"addressKeyUsrName";
NSString * const addressKeyUsrPhone      = @"addressKeyUsrPhone";
NSString * const addressKeyAddressDetail = @"addressKeyAddressDetail";
NSString * const addressKeyAddressID     = @"addressKeyAddressID";

/**
 *  订单的相关键值
 */
NSString * const orderKeyID                 = @"orderKeyID";
NSString * const orderKeyOrderID            = @"orderKeyOrderID";
NSString * const orderKeyStatus             = @"orderKeyStatus";
NSString * const orderKeyGoodsCount         = @"orderKeyGoodsCount";
NSString * const orderKeyTotalPrice         = @"orderKeyTotalPrice";
NSString * const orderKeyTransPrice         = @"orderKeyTransPrice";
NSString * const orderKeyReceiverName       = @"orderKeyReceiverName";
NSString * const orderKeyGoodsImageUrlArray = @"orderKeyGoodsImageUrlArray";

/**
 *  物流的相关键值
 */
NSString * const transKeyCompanyID  = @"transKeyCompanyID";
NSString * const transKeyShipCodeID = @"transKeyShipCodeID";

/**
 *  退货相关键值
 */
NSString * const returnGoodsKeyGoodsName   = @"returnGoodsKeyGoodsName";
NSString * const returnGoodsKeyStatus      = @"returnGoodsKeyStatus";
NSString * const returnGoodsKeyImagePath   = @"returnGoodsKeyImagePath";
NSString * const returnGoodsKeyOrderId     = @"returnGoodsKeyOrderId";
NSString * const returnGoodsKeyGoodsId     = @"returnGoodsKeyGoodsId";
NSString * const returnGoodsKeyGoodsGspIds = @"returnGoodsKeyGoodsGspIds";
NSString * const returnGoodsKeyReason      = @"returnGoodsKeyReason";
NSString * const returnGoodsKeyselfAddress = @"returnGoodsKeyselfAddress";
NSString * const returnGoodsKeyLogId       = @"returnGoodsKeyLogId";

- (NSDictionary *)getReturnDicfromData:(NSDictionary *)originData
{
    
    NSString *GoodsGspIds = @"";
    NSString *selfAddress = @"";
    if (originData[@"goodsGspIds"] != nil) {
        GoodsGspIds = originData[@"goodsGspIds"];
    }
    if (originData[@"selfAddress"] != nil) {
        selfAddress = originData[@"selfAddress"];
    }
    NSDictionary *result = @{
                             returnGoodsKeyImagePath: originData[@"goodsMainphotoPath"],
                             returnGoodsKeyGoodsName: originData[@"goodsName"],
                             returnGoodsKeyStatus: originData[@"goodsReturnStatus"],
                             returnGoodsKeyOrderId: originData[@"returnOrderId"],
                             returnGoodsKeyGoodsId: originData[@"goodsId"],
                             returnGoodsKeyGoodsGspIds: GoodsGspIds,
                             returnGoodsKeyReason: originData[@"returnContent"],
                             returnGoodsKeyselfAddress: selfAddress,
                             returnGoodsKeyLogId: originData[@"id"],
                             };
    
    return result;
}


+ (NSString *)getTransContextFromData:(NSDictionary *)originData
{
    NSString *resultData = [NSString stringWithFormat:@"%@ \n %@",
                            originData[@"context"],originData[@"time"]];
    return resultData;
}

- (NSDictionary *)getOrderDatafromData:(NSDictionary *)originData fromManager:(APIManager *)manager
{
    NSDictionary *resultData = nil;
    NSArray *goodsInfo = originData[@"goodsInfos"];
    NSInteger totalCount = 0;
    NSMutableArray *photoPaths = [[NSMutableArray alloc] init];
    
    for (NSDictionary *goodsDic in goodsInfo) {
        totalCount += ((NSNumber *)goodsDic[@"goodsCount"]).integerValue;
        [photoPaths addObject:goodsDic[@"goodsMainphotoPath"]];
    }
    
    NSString *expressCompanyId = originData[@"expressCompanyId"];
    NSString *shipCode = originData[@"shipCode"];
    if (originData[@"expressCompanyId"] == nil || originData[@"shipCode"] == nil) {
        expressCompanyId = @"";
        shipCode = @"";
    }
    resultData = @{
                   orderKeyID: originData[@"id"],
                   orderKeyOrderID: originData[@"orderId"],
                   orderKeyStatus: originData[@"orderStatus"],
                   orderKeyTotalPrice: originData[@"totalPrice"],
                   orderKeyReceiverName: originData[@"receiverName"],
                   orderKeyTransPrice: originData[@"shipPrice"],
                   orderKeyGoodsCount: @(totalCount),
                   orderKeyGoodsImageUrlArray: photoPaths.copy,
                   transKeyCompanyID: expressCompanyId,
                   transKeyShipCodeID: shipCode,
                   };
    
    return resultData;
}


- (NSDictionary *)getAddressfromData:(NSDictionary *)originData fromManager:(APIManager *)manager
{
    NSDictionary *resultData = nil;
    
    //TODO:根据不同的数据model对数据进行封装
    resultData = [self getAddressfromData:originData];
    
    /*if ([manager isKindOfClass:<#(__unsafe_unretained Class)#>]) {
        <#statements#>
    }
    
    if ([manager isKindOfClass:<#(__unsafe_unretained Class)#>]) {
        <#statements#>
    }
    
    if ([manager isKindOfClass:<#(__unsafe_unretained Class)#>]) {
        <#statements#>
    }*/

    return resultData;
}

- (NSArray *)getshopStores:(NSArray *)orderListArray
{
    NSMutableArray *transList = [[NSMutableArray alloc] init];
    for (NSDictionary * transDic in orderListArray) {
        NSDictionary *shopStore = transDic[@"shopStore"];
        if (shopStore == nil) {
            shopStore = @{
                          @"id": @(0)
                          };
        }
        [transList addObject:shopStore];
    }
    return transList.copy;
}

- (NSArray *)getGoodsCartListList:(NSArray *)orderListArray
{
    NSMutableArray *transList = [[NSMutableArray alloc] init];
    for (NSDictionary * transDic in orderListArray) {
        [transList addObject:(NSArray *)transDic[@"goodsCartList"]];
    }
    return transList.copy;
}

- (NSArray *)getCouponInfoList:(NSArray *)orderListArray
{
    NSMutableArray *transList = [[NSMutableArray alloc] init];
    for (NSDictionary * transDic in orderListArray) {
        [transList addObject:(NSArray *)transDic[@"couponInfoList"]];
    }
    return transList.copy;
}

- (NSArray *)getTransList:(NSArray *)orderListArray
{
    NSMutableArray *transList = [[NSMutableArray alloc] init];
    for (NSDictionary * transDic in orderListArray) {
        [transList addObject:[self getShopData:(NSArray *)transDic[@"transList"] keyword:@"key"]];
    }
    return transList.copy;
}

- (NSArray *)getShopData:(NSArray *)shopArray keyword:(NSString *)key
{
    NSMutableArray *propertyList = [[NSMutableArray alloc] init];
    for (NSDictionary * transDic in shopArray) {
        [propertyList addObject:transDic[key]];
    }
    return propertyList.copy;
}

- (NSDictionary *)getAddressfromData:(NSDictionary *)originData
{
    return @{
             addressKeyUsrName: originData[@"trueName"],
             addressKeyUsrPhone: originData[@"mobile"],
             addressKeyAddressDetail: [NSString stringWithFormat:@"%@ %@",originData[@"areaName"],originData[@"areaInfo"]],
             addressKeyAddressID: originData[@"id"],
             };
    
}
@end
