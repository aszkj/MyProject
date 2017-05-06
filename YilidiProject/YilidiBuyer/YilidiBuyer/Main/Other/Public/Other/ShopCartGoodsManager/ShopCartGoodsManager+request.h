//
//  ShopCartGoodsManager+request.h
//  YilidiBuyer
//
//  Created by yld on 16/6/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsManager.h"

@interface ShopCartGoodsManager (request)

/**
 *  同步购物车
 */
- (void)requestSychronizeShopCartData;

/**
 *  清除服务器购物车
 */
- (void)requestClearShopCartData;

/**
 *  删除购物车商品
 */
- (void)requestDeleteShopCartGoodsForGoodsIds:(NSArray *)goodsIds;
/**
 *  调整购物车数量
 */
- (void)requestAdjustShopCartGoodsDataOfGoodsId:(GoodsModel *)goodsModel
                                          IsAdd:(BOOL)isAdd;

@end
