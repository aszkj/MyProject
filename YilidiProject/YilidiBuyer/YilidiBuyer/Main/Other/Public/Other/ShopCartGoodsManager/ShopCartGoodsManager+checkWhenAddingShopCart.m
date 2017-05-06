//
//  ShopCartGoodsManager+checkWhenAddingShopCart.m
//  YilidiBuyer
//
//  Created by yld on 16/7/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsManager+checkWhenAddingShopCart.h"
#import "GlobleConst.h"
#import "ShopCartGoodsManager+shopCartInfo.h"

@implementation ShopCartGoodsManager (checkWhenAddingShopCart)

- (NSString *)canbeAddedToShopCartOfGoodsModel:(GoodsModel *)goodsModel {
    
    if (!kCurrentCummunityStoreBusinessStatus) {
        return kAlertStoreClosed;
    }
    
    NSInteger nowGoodsCount = [[ShopCartGoodsManager sharedManager] goodsNumberOfGoodsModel:goodsModel];

    if (nowGoodsCount + 1 > goodsModel.goodsStock.integerValue) {
        return kAlertGoodsStockNotEnough;
    }

    return [self _alertWhenCountLimitOfGoodsModel:goodsModel];
}

- (NSString *)_alertWhenCountLimitOfGoodsModel:(GoodsModel *)goodsModel {
    
    if (goodsModel.goodsType == GoodsType_NormalPennyGoods) {
        if ([self _hasReachedDennyGoodsLimitCountOfDennyGoodsModel:goodsModel]) {
            return kAlertBuyyingPennyGoods;
        }
    }else if (!isEmpty(goodsModel.seckillActivityId)){
        if ([self _biggerThanLimitCountAfterAddingGoodsModel:goodsModel]) {
            return kAlertGoodsNowCountBiggerThanlimitCount;
        }
    }
    return nil;
}

- (BOOL)_hasReachedDennyGoodsLimitCountOfDennyGoodsModel:(GoodsModel *)goodsModel {
    NSInteger nowGoodsCount = [[ShopCartGoodsManager sharedManager] goodsNumberOfGoodsModel:goodsModel];
    return nowGoodsCount + 1 >  KDennyGoodsLimitCount;
}

- (BOOL)_biggerThanLimitCountAfterAddingGoodsModel:(GoodsModel *)goodsModel {
     NSInteger nowGoodsCount = [[ShopCartGoodsManager sharedManager] goodsNumberOfGoodsModel:goodsModel];
    return nowGoodsCount + 1 >  goodsModel.limitBuyNumber.integerValue;
}

- (BOOL)isAddingTheSameTypeGoodsOfGoodsModel:(GoodsModel *)goodsModel{
    
    if (![ShopCartGoodsManager sharedManager].shopCartGoodsNumber) {
        return YES;
    }
    
    GoodsType shopCartGoodsType = [[ShopCartGoodsManager sharedManager] shopCartGoodsType];
    GoodsType addShopCartGoodsType = [goodsModel dealGoodsType];
    BOOL isTheSame = NO;
    if (shopCartGoodsType != addShopCartGoodsType) {
        if (shopCartGoodsType == GoodsType_NormalGoods && addShopCartGoodsType == GoodsType_NormalPennyGoods) {
            isTheSame = YES;
        }
    }else {
        isTheSame = YES;
    }
    return isTheSame;
}

- (BOOL)isValidateCanbeBuyOfGoodsModel:(GoodsModel *)goodsModel{

    if (goodsModel.goodsOnShelf.integerValue && goodsModel.limitBuyNumber.integerValue&& goodsModel.goodsStock.integerValue) {
        return YES;
    }
    return NO;
}


- (NSString *)addingDifferentGoodsTypeAlert{
    
    return kAlertDifferentGoodsToShopCart;
}

- (void)clearShopCartDataWhenAddingDifferentTypeGoods {
    [[ShopCartGoodsManager sharedManager] clearAllShopCartData];

}

- (BOOL)isRealTheSameGoodsComparingOutShopCartGoods:(GoodsModel *)outShopCartGoodsModel
                                  withShopCartGoods:(GoodsModel *)shopCartGoodsModel
{
    //前提商品id得相同
    if (![outShopCartGoodsModel.goodsId isEqualToString:shopCartGoodsModel.goodsId]) {
        return NO;
    }
    
    //两个都是空的
    if (isEmpty(outShopCartGoodsModel.seckillActivityId) && isEmpty(shopCartGoodsModel.seckillActivityId)) {
        return YES;
    }else {
        if (outShopCartGoodsModel.seckillActivityId && shopCartGoodsModel.seckillActivityId) {//两个都不是空的
            if ([outShopCartGoodsModel.seckillActivityId isEqualToString:shopCartGoodsModel.seckillActivityId]) {
                return YES;
            }else {
                return NO;
            }
        }else {//至少有一个为空
            return NO;
        }
    }
    
    return YES;
}

@end
