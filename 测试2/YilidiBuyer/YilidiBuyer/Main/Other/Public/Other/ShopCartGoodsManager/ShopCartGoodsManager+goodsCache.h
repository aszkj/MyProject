//
//  ShopCartGoodsManager+goodsCache.h
//  YilidiBuyer
//
//  Created by yld on 16/8/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsManager.h"

@interface ShopCartGoodsManager (goodsCache)

-(void)initCache;

- (void)doShopCartCache;

- (void)cleanShopCartCache;
@end
