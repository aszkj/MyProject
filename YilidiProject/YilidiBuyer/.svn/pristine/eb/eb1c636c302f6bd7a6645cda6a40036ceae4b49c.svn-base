//
//  ShopCartGoodsManager+ensureShopCartGoodsType.m
//  YilidiBuyer
//
//  Created by yld on 16/8/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsManager+ensureShopCartGoodsType.h"
#import "ShopCartGoodsManager+shopCartInfo.h"

@implementation ShopCartGoodsManager (ensureShopCartGoodsType)

- (void)initShopCartGoodsType {
    NSArray *shopCartGoods = self.allShopCartGoods;
    if (!shopCartGoods.count) {
        return;
    }
    GoodsModel *goodsModel = shopCartGoods.firstObject;
    self.shopCartGoodsType = goodsModel.goodsType;
}

- (void)ensureShopCartGoodsTypeByTheFirstGoodsModel:(GoodsModel *)firstGoodsModel {
    if (firstGoodsModel.goodsType != GoodsType_NormalPennyGoods) {
        self.shopCartGoodsType = firstGoodsModel.goodsType;
    }else {
        self.shopCartGoodsType = GoodsType_NormalGoods;
    }
}


@end
