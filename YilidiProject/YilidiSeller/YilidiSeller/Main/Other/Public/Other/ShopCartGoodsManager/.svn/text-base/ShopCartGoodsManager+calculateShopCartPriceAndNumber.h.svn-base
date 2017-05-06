//
//  ShopCartGoodsManager+calculateShopCartPriceAndNumber.h
//  YilidiBuyer
//
//  Created by yld on 16/6/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DispatchGoodsManager.h"

@interface DispatchGoodsManager (calculateShopCartPriceAndNumber)
/**
 *  未进入购物车页面，计算总价，数量
 */
-(void)initTotalPriceTotalNumber;
/**
 *  加单个商品，计算累加价格
 */
- (void)calculatePriceAndSelectedTotalGoodsNumberWhenAddSubGoodsModel:(GoodsModel *)goodsModel isAdd:(BOOL)isAdd;
/**
 *  进入购物车页，重新计算总价，
 */
- (void)recalculateTotalPriceWhenMakeSureShopCartData;
@end
