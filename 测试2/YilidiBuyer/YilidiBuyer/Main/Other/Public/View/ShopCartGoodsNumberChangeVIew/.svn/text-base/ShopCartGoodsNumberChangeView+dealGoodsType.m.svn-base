//
//  ShopCartGoodsNumberChangeView+dealGoodsType.m
//  YilidiBuyer
//
//  Created by yld on 16/7/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsNumberChangeView+dealGoodsType.h"
#import "ShopCartGoodsManager.h"
#import "GlobleConst.h"

@implementation ShopCartGoodsNumberChangeView (dealGoodsType)

- (BOOL)isTheSameTypeGoodsOfAddingShopCart {
    
    GoodsType shopCartGoodsType = [[ShopCartGoodsManager sharedManager] shopCartGoodsType];
    GoodsType addShopCartGoodsType = [self.goodsModel dealGoodsType];
    BOOL isTheSame = NO;
    if (shopCartGoodsType != addShopCartGoodsType) {
        if (shopCartGoodsType == GoodsType_NormalGoods && addShopCartGoodsType == GoodsType_NormalPennyGoods) {
            isTheSame = YES;
        }
    }else {
        isTheSame = YES;
    }
    return isTheSame;
}

- (NSString *)addDifferentGoodsTypeAlertStr {
//    NSString *shopCartGoodsTypeStr = nil;
//    NSString *addGoodsTypeStr = nil;
//    GoodsType shopCartGoodsType = [[ShopCartGoodsManager sharedManager] shopCartGoodsType];
//    if (shopCartGoodsType == GoodsType_NormalGoods) {
//        shopCartGoodsTypeStr = @"普通商品";
//        addGoodsTypeStr = @"VIP商品";
//    }else if (shopCartGoodsType == GoodsType_VipGoods) {
//        shopCartGoodsTypeStr = @"VIP商品";
//        addGoodsTypeStr = @"普通商品";
//    }
//    return [NSString stringWithFormat:@"抱歉，你当前添加的%@,是否确认清除之前的购物车%@",addGoodsTypeStr,shopCartGoodsTypeStr];
    return kAlertDifferentGoodsToShopCart;

}

@end
