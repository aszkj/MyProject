//
//  ShopCartGoodsManager+calculateShopCartPriceAndNumber.m
//  YilidiBuyer
//
//  Created by yld on 16/6/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsManager+calculateShopCartPriceAndNumber.h"

@implementation DispatchGoodsManager (calculateShopCartPriceAndNumber)

-(void)initTotalPriceTotalNumber {
    self.totalPrice = 0.0;
    self.shopCartGoodsNumber = 0;
    for (GoodsModel *goodsModel in self.goodsShopCartDictionary.allValues) {
        self.shopCartGoodsNumber += goodsModel.goodsNumber.integerValue;
        //        if (goodsModel.selected) {
        self.totalPrice += goodsModel.goodsNumber.integerValue * goodsModel.goodsPurchasePrice.floatValue;
        //        }
    }
}

- (void)calculatePriceAndSelectedTotalGoodsNumberWhenAddSubGoodsModel:(GoodsModel *)goodsModel isAdd:(BOOL)isAdd{
    if (!goodsModel.selected) {
        return;
    }
    if (isAdd) {
        self.totalPrice += goodsModel.goodsPurchasePrice.floatValue * goodsModel.basicOrderNumber.integerValue;
        self.selectedShopCartGoodsNumber += goodsModel.basicOrderNumber.integerValue;
    }else {
        self.totalPrice -= goodsModel.goodsPurchasePrice.floatValue * goodsModel.basicOrderNumber.integerValue;
        self.selectedShopCartGoodsNumber -= goodsModel.basicOrderNumber.integerValue;
    }
}

- (void)recalculateTotalPriceWhenMakeSureShopCartData {
    self.totalPrice = 0.0;
    self.shopCartGoodsNumber = 0;
    for (GoodsModel *goodsModel in self.goodsShopCartDictionary.allValues) {
        self.shopCartGoodsNumber += goodsModel.goodsNumber.integerValue;
//        if (goodsModel.goodsOnShelf.integerValue) {//上架，才计算
            self.totalPrice += goodsModel.goodsNumber.integerValue * goodsModel.goodsPurchasePrice.floatValue;
//        }
    }
}

@end
