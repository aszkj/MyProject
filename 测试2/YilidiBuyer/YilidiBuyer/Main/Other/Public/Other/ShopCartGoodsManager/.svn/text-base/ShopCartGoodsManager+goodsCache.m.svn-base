//
//  ShopCartGoodsManager+goodsCache.m
//  YilidiBuyer
//
//  Created by yld on 16/8/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsManager+goodsCache.h"
#import "TMCache.h"
static NSString *shopCartGoodsCacheKey = @"shopCartGoodsCacheKey";

@implementation ShopCartGoodsManager (goodsCache)

-(void)initCache {
    
    NSDictionary *cachedGoodsDic = [[TMCache sharedCache] objectForKey:shopCartGoodsCacheKey];
    if (!isEmpty(cachedGoodsDic)) {
        [self.goodsShopCartDictionary addEntriesFromDictionary:cachedGoodsDic];
    }
}


- (void)doShopCartCache {
    [[TMCache sharedCache] setObject:self.goodsShopCartDictionary forKey:shopCartGoodsCacheKey];
}


- (void)cleanShopCartCache {
    
    [[TMCache sharedCache] setObject:nil forKey:shopCartGoodsCacheKey];
    [[TMCache sharedCache] removeObjectForKey:shopCartGoodsCacheKey];
    
}


@end
