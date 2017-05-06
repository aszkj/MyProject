//
//  ShopCartGoodsNumberChangeView+operaterShopCart.m
//  YilidiBuyer
//
//  Created by yld on 16/5/28.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsNumberChangeView+shopCartRelated.h"
#import "DispatchGoodsManager.h"
#import "UIView+firstResponseController.h"
#import "DLDispatchGoodsOrderVC.h"

@implementation ShopCartGoodsNumberChangeView (shopCartRelated)

- (void)operaterShopCartGoodsManagerGoodsChangedOfGoodsModel:(GoodsModel *)goodsModel isAdd:(BOOL)isAdd{
   DispatchGoodsManager *shopCartManager = [DispatchGoodsManager sharedManager];
    UIViewController *reponseVC = [self firstResponseController];
    BOOL isOperateInShopCartPage = NO;
    if ([reponseVC isMemberOfClass:[DLDispatchGoodsOrderVC class]]) {
        isOperateInShopCartPage = YES;
    }
    if (isAdd) {
        [shopCartManager addShopCartGoodsWithGoodsModel:goodsModel isInShopCartPage:isOperateInShopCartPage];
    }else {
        [shopCartManager subShopCartGoodsWithGoodsModel:goodsModel isInShopCartPage:isOperateInShopCartPage];
    }
}

- (NSInteger)goodsCountOfGoodsId:(NSString *)goodsId {

    return [[DispatchGoodsManager sharedManager] goodsNumberOfGoodsId:goodsId];
}

@end
