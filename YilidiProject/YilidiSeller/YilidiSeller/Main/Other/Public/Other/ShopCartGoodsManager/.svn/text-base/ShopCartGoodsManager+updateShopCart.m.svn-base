//
//  ShopCartGoodsManager+updateShopCart.m
//  YilidiBuyer
//
//  Created by yld on 16/6/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsManager+updateShopCart.h"
#import "ProjectRelativeKey.h"
#import "ProjectRelativeDefineNotification.h"
#import "ShopCartGoodsManager+calculateShopCartPriceAndNumber.h"

@implementation DispatchGoodsManager (updateShopCart)

-(void)updateShopCartGoodsDicWithGoodsArr:(NSArray *)goodsArr
                     isSychronizeShopCart:(BOOL)isSychronizeShopCart
{
    [self _dealUpdateGoodsUIInShopCartLogicWithTheLatestShopCartGoods:goodsArr isSychroNize:isSychronizeShopCart];
    
    [self _updateLocatShopCartDicWithWithGoodsArr:goodsArr];
    
    [self _updateLocalShopCartTotalPriceTotalNumberWithGoodsArr:goodsArr isSychronizeShopCart:isSychronizeShopCart];
    
    [self _notifyUpdateShopCartTotalNumberUI];
}

- (void)_updateLocatShopCartDicWithWithGoodsArr:(NSArray *)goodsArr {
    NSMutableDictionary *goodsDic = [NSMutableDictionary dictionaryWithCapacity:goodsArr.count];
    [goodsArr enumerateObjectsUsingBlock:^(GoodsModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        [goodsDic setObject:model forKey:model.goodsId];
    }];
    self.goodsShopCartDictionary = goodsDic;
}

- (void)_updateLocalShopCartTotalPriceTotalNumberWithGoodsArr:(NSArray *)goodsArr
                                         isSychronizeShopCart:(BOOL)isSychronizeShopCart {
    if (isSychronizeShopCart) {
        [self initTotalPriceTotalNumber];
    }else {
        //交给购物车页面触发全选计算（购物车原有的计算流程）
//        [self recalculateTotalPriceWhenMakeSureShopCartData];
    }
}

- (void)_dealUpdateGoodsUIInShopCartLogicWithTheLatestShopCartGoods:(NSArray *)latestShopCartGoods isSychroNize:(BOOL)isSychroNize {
    if (!isSychroNize) {
        return;
    }
    NSArray *needUpdateGoods = [self _findNeedToUpdateShopCartGoodsWithTheLatestShopCartGoods:latestShopCartGoods];
    [self _nofityTheNeedUpdateGoods:needUpdateGoods];
}

- (void)_notifyUpdateShopCartTotalNumberUI {
    [kNotification postNotificationName:KNotificationShopCartBadgeValueNeedChange object:@(YES)];
}

/**
 *  根据同步购物车之后从服务器得到的最新的数据和本地的购物车数据，来找到需要更新的购物车商品
 *
 *  @param latestShopCartGoods 服务器最新的购物车商品
 *
 *  @return 需要更新的商品，同样的id商品数量改变了，以及新增的商品
 */
- (NSArray *)_findNeedToUpdateShopCartGoodsWithTheLatestShopCartGoods:(NSArray *)latestShopCartGoods {
    NSMutableArray *tempNeedToUpdateGoodsArr = [NSMutableArray arrayWithCapacity:latestShopCartGoods.count];
    NSArray *localShopCartGoods = self.goodsShopCartDictionary.allValues;
    /**
     *  两个数据源对比，在本地购物车中，数量改变了，才需要更新UI，不在本地购物车中，说明以前加过，那么同步之后肯定也需要显示以前加的数量
     */
    for (GoodsModel *latestModel in latestShopCartGoods) {
        BOOL latestModelInTheLocalShopCartGoods = NO;
        for (GoodsModel *localModel in localShopCartGoods) {
            //在本地购物车中有
            if ([latestModel.goodsId isEqualToString:localModel.goodsId]) {
                latestModelInTheLocalShopCartGoods = YES;
                if (latestModel.goodsNumber.integerValue != localModel.goodsNumber.integerValue) {
                    [tempNeedToUpdateGoodsArr addObject:latestModel];
                }
                break;
            }
        }
        //在本地购物车没有
        if (!latestModelInTheLocalShopCartGoods) {
            [tempNeedToUpdateGoodsArr addObject:latestModel];
        }
        
    }
    return [tempNeedToUpdateGoodsArr copy];
}

- (void)_nofityTheNeedUpdateGoods:(NSArray *)needUpdateGoods {
    for (GoodsModel *goodsModel in needUpdateGoods) {
        NSDictionary *postDic = @{
                                  KGoodsChangeGoodsNumberKey:goodsModel.goodsNumber,
                                  KGoodsChangeIsAddKey:@(YES)};
        [kNotification postNotificationName:KGoodsIdNotificationNameWithGoodsId(goodsModel.goodsId) object:nil userInfo:postDic];
    }
}



@end
