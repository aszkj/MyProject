//
//  ShopCartGoodsManager+calculateShopCartPriceAndNumber.h
//  YilidiBuyer
//
//  Created by yld on 16/6/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsManager.h"

@interface ShopCartGoodsManager (calculateShopCartPriceAndNumber)
/**
 *  未进入购物车页面，计算总价，数量
 */
-(void)initTotalPriceTotalNumber;
/**
 *  加减单个商品，计算累加价格
 */
- (void)calculateActuralSelectedShopCartGoodsTotalPriceAndNumberWhenAddSubGoodsModel:(GoodsModel *)goodsModel isAdd:(BOOL)isAdd isInShopCartPage:(BOOL)isInShopCartPage;
/**
 *  进入购物车页，重新计算总价，
 */
- (void)recalculateTotalPriceWhenMakeSureShopCartData;
/**
 *  计算被替换的商品的数量和价格
 */
- (void)calculateNumberAndPriceForBeReplacedGoodsModel:(GoodsModel *)replacedGoodsModel;
@end
