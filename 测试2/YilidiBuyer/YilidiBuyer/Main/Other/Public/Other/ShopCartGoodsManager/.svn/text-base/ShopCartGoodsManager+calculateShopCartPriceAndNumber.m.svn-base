//
//  ShopCartGoodsManager+calculateShopCartPriceAndNumber.m
//  YilidiBuyer
//
//  Created by yld on 16/6/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsManager+calculateShopCartPriceAndNumber.h"
#import "ShopCartGoodsManager+checkWhenAddingShopCart.h"

@implementation ShopCartGoodsManager (calculateShopCartPriceAndNumber)

-(void)initTotalPriceTotalNumber {
    self.totalPrice = 0.0;
    self.shopCartGoodsNumber = 0;
    for (GoodsModel *goodsModel in self.goodsShopCartDictionary.allValues) {
        self.shopCartGoodsNumber += goodsModel.goodsNumber.integerValue;
        self.totalPrice += goodsModel.goodsNumber.integerValue * goodsModel.goodsOrderPrice.floatValue;
    }
}

- (void)calculateActuralSelectedShopCartGoodsTotalPriceAndNumberWhenAddSubGoodsModel:(GoodsModel *)goodsModel isAdd:(BOOL)isAdd isInShopCartPage:(BOOL)isInShopCartPage{
    if (!goodsModel.selected) {
        return;
    }
    CGFloat goodsRealCaculatePrice = 0.0;
    if (isInShopCartPage) {//购物车页统一用orderPrice,
        goodsRealCaculatePrice = goodsModel.goodsOrderPrice.floatValue;
    }else {//非购物车页的价格变化的，
        goodsRealCaculatePrice = [[self realGoodsCalculatePriceOfGoodsModel:goodsModel] floatValue];
    }
    
    if (isAdd) {
        self.totalPrice += goodsRealCaculatePrice;
        self.selectedShopCartGoodsNumber ++;
    }else {
        self.totalPrice -= goodsRealCaculatePrice;
        self.selectedShopCartGoodsNumber --;
    }
}

- (void)recalculateTotalPriceWhenMakeSureShopCartData {
    self.totalPrice = 0.0;
    self.shopCartGoodsNumber = 0;
    for (GoodsModel *goodsModel in self.goodsShopCartDictionary.allValues) {
        self.shopCartGoodsNumber += goodsModel.goodsNumber.integerValue;
        if ([self isValidateCanbeBuyOfGoodsModel:goodsModel]) {
            self.totalPrice += goodsModel.goodsNumber.integerValue * goodsModel.goodsOrderPrice.floatValue;
        }
    }
}

- (CGFloat)priceOfReplacedGoodsModel:(GoodsModel *)cachedGoodsModel {

    if (!isEmpty(cachedGoodsModel.seckillActivityId)) {
        if (!isEmpty(cachedGoodsModel.seckillPrice)) {
            return cachedGoodsModel.seckillPrice.floatValue;
        }else {
            return cachedGoodsModel.goodsOrderPrice.floatValue;
        }
    }
    
    return cachedGoodsModel.goodsOrderPrice.floatValue;
}


- (NSNumber *)realGoodsCalculatePriceOfGoodsModel:(GoodsModel *)goodsModel {
    if (!isEmpty(goodsModel.seckillActivityId)) {
        return goodsModel.seckillPrice;
    }else {
        return goodsModel.goodsOrderPrice;
    }
}

- (void)calculateNumberAndPriceForBeReplacedGoodsModel:(GoodsModel *)replacedGoodsModel {

    NSInteger detaCount = replacedGoodsModel.goodsNumber.integerValue - 1;
    self.shopCartGoodsNumber -= detaCount;
    self.totalPrice -= replacedGoodsModel.goodsNumber.integerValue * [self priceOfReplacedGoodsModel:replacedGoodsModel];
}


@end
