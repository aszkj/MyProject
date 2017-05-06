//
//  ShopCartGoodsManager+request.m
//  YilidiBuyer
//
//  Created by yld on 16/6/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsManager+request.h"
#import "GlobleConst.h"
#import "ProjectRelativeKey.h"
#import "ShopCartGoodsManager+shopCartInfo.h"

@implementation ShopCartGoodsManager (request)

- (void)requestSychronizeShopCartData {
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithCapacity:0];
    NSArray *shopCartGoods = [ShopCartGoodsManager sharedManager].allGoodsIdToNumberArr;
    if (shopCartGoods.count >0) {
        [requestParam setObject:shopCartGoods forKey:@"cartInfo"];
    }
    [requestParam setObject:kCommunityStoreId forKey:KStoreIdKey];
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_SychronizeShopCart block:^(NSDictionary *resultDic, NSError *error) {
        
    }];
}

- (void)requestClearShopCartData {
    if (!UserIsLogin) {
        return;
    }
    NSDictionary *requestDic = @{@"products":[self allGoodsIds]};
    [AFNHttpRequestOPManager postWithParameters:requestDic subUrl:kUrl_ClearShopCartInfo block:^(NSDictionary *resultDic, NSError *error) {
        
    }];
}

- (void)requestDeleteShopCartGoodsForGoodsIds:(NSArray *)goodsIds {
    if (!UserIsLogin) {
        return;
    }
    NSDictionary *requestDic = @{@"products":goodsIds};
    [AFNHttpRequestOPManager postWithParameters:requestDic subUrl:kUrl_ClearShopCartInfo block:^(NSDictionary *resultDic, NSError *error) {
        
    }];
}


- (void)requestAdjustShopCartGoodsDataOfGoodsId:(GoodsModel *)goodsModel
                                          IsAdd:(BOOL)isAdd{
    if (!UserIsLogin) {
        return;
    }
    NSInteger typeNumber = isAdd ? 1 : 0;
    //actId
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithCapacity:4];
    [requestParam setObject:goodsModel.goodsId forKey:@"saleProductId"];
    [requestParam setObject:@(typeNumber) forKey:@"type"];
    [requestParam setObject:kCommunityStoreId forKey:KStoreIdKey];
    if (!isEmpty(goodsModel.seckillActivityId)) {
        [requestParam setObject:goodsModel.seckillActivityId forKey:@"actId"];
    }
    
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_AdjustShopCartNumber block:^(NSDictionary *resultDic, NSError *error) {
        
    }];
    
}


@end
