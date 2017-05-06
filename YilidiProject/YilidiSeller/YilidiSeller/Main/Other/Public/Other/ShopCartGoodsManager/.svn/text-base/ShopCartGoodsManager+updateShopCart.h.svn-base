//
//  ShopCartGoodsManager+updateShopCart.h
//  YilidiBuyer
//
//  Created by yld on 16/6/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DispatchGoodsManager.h"

@interface DispatchGoodsManager (updateShopCart)
/**
 *  更新购物车商品
 *  @param goodsArr             最新服务器购物车商品
 *  @param isSychronizeShopCart 是否是同步，若是同步，则更新完数据后，本地需要更新的购物车商品数量也得更新，若不是同步，则不需要，因为此时本地购物车商品的数量都是累加之后的，只不过更新商品的其他信息
 */
-(void)updateShopCartGoodsDicWithGoodsArr:(NSArray *)goodsArr
                     isSychronizeShopCart:(BOOL)isSychronizeShopCart;

@end
