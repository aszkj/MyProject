//
//  ShopCartGoodsNumberChangeView+operaterShopCart.m
//  YilidiBuyer
//
//  Created by yld on 16/5/28.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsNumberChangeView+shopCartRelated.h"
#import "ShopCartGoodsManager.h"
#import "UIView+firstResponseController.h"
#import "DLShopCarVC.h"
#import "ShopCartGoodsManager+shopCartInfo.h"

@implementation ShopCartGoodsNumberChangeView (shopCartRelated)

- (void)operaterShopCartGoodsManagerGoodsChangedOfGoodsModel:(GoodsModel *)goodsModel isAdd:(BOOL)isAdd{
   ShopCartGoodsManager *shopCartManager = [ShopCartGoodsManager sharedManager];
    UIViewController *reponseVC = [self firstResponseController];
    BOOL isOperateInShopCartPage = NO;
    if ([reponseVC isMemberOfClass:[DLShopCarVC class]]) {
        isOperateInShopCartPage = YES;
    }
    if (isAdd) {
        [shopCartManager addShopCartGoodsWithGoodsModel:goodsModel isInShopCartPage:isOperateInShopCartPage];
    }else {
        [shopCartManager subShopCartGoodsWithGoodsModel:goodsModel isInShopCartPage:isOperateInShopCartPage];
    }
}

- (NSInteger)goodsCountOfGoodsModel:(GoodsModel *)goodsModel{

    return [[ShopCartGoodsManager sharedManager] goodsNumberOfGoodsModel:goodsModel];
}

@end
