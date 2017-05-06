//
//  ShopCartGoodsManager+checkWhenAddingShopCart.h
//  YilidiBuyer
//
//  Created by yld on 16/7/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsManager.h"

@interface ShopCartGoodsManager (checkWhenAddingShopCart)
/**
 *  检查能否被添加到购物车
 *
 *  @param goodsModel
 *
 *  @return 返回错误信息，如果为空，则可以添加，否则，不能
 */
- (NSString *)canbeAddedToShopCartOfGoodsModel:(GoodsModel *)goodsModel;


/**
 *  是否加入了不同类型的商品，目前购物车中只有普通和VIP两种商品
 */
- (BOOL)isAddingTheSameTypeGoodsOfGoodsModel:(GoodsModel *)goodsModel;
/**
 *  添加不同商品时候的提示
 */
- (NSString *)addingDifferentGoodsTypeAlert;
/**
 *  添加不同商品，清除购物车
 */
- (void)clearShopCartDataWhenAddingDifferentTypeGoods;
/**
 *  商品是否有效能够购买
 */
- (BOOL)isValidateCanbeBuyOfGoodsModel:(GoodsModel *)goodsModel;
/**
 *  是不是真的是同一个商品，将要加入购物车的和原来的
 */
- (BOOL)isRealTheSameGoodsComparingOutShopCartGoods:(GoodsModel *)outShopCartGoodsModel
                                  withShopCartGoods:(GoodsModel *)shopCartGoodsModel;

@end
