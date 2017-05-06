//
//  ShopCartGoodsManager+shopCartInfo.m
//  YilidiBuyer
//
//  Created by yld on 16/8/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsManager+shopCartInfo.h"
#import "NSArray+SUIAdditions.h"
#import "ShopCartGoodsManager+checkWhenAddingShopCart.h"

@implementation ShopCartGoodsManager (shopCartInfo)

- (NSInteger)goodsNumberOfGoodsModel:(GoodsModel *)goodsModel{
    GoodsModel *cachedGoodsModel = self.goodsShopCartDictionary[goodsModel.goodsId];
    if (isEmpty(cachedGoodsModel)) {
        return 0;
    }else {
        if ([self isRealTheSameGoodsComparingOutShopCartGoods:goodsModel withShopCartGoods:cachedGoodsModel]) {
            return cachedGoodsModel.goodsNumber.integerValue;
        }else {
            return 0;
        }
    }
    return cachedGoodsModel.goodsNumber.integerValue;
}

- (NSArray *)allShopCartGoods {
    return self.goodsShopCartDictionary.allValues;
}

- (NSArray *)allGoodsIds {
    
    return [self.allShopCartGoods sui_map:^NSString *(GoodsModel* goodsModel, NSUInteger index) {
        return goodsModel.goodsId;
    }];
}


- (NSArray *)allGoodsIdToNumberArr{
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:self.goodsShopCartDictionary.count];
    [self.goodsShopCartDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        GoodsModel *goodsModel = (GoodsModel *)obj;
        NSString *goodsId = (NSString *)key;
        NSMutableDictionary *tempMutableDic = [NSMutableDictionary dictionaryWithCapacity:3];
        [tempMutableDic setObject:goodsId forKey:@"saleProductId"];
        [tempMutableDic setObject:goodsModel.goodsNumber forKey:@"cartNum"];
        if (!isEmpty(goodsModel.seckillActivityId)) {
            [tempMutableDic setObject:goodsModel.seckillActivityId forKey:@"actId"];
        }
        [tempArr addObject:tempMutableDic];
    }];
    
    return [tempArr copy];
}

- (NSArray *)selectedGoodsIdToNumberArr {
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:self.goodsShopCartDictionary.count];
    [self.goodsShopCartDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        GoodsModel *goodsModel = (GoodsModel *)obj;
        NSString *goodsId = (NSString *)key;
        if (goodsModel.selected) {
            if ([self isValidateCanbeBuyOfGoodsModel:goodsModel]) {
                NSMutableDictionary *tempMutableDic = [NSMutableDictionary dictionaryWithCapacity:3];
                [tempMutableDic setObject:goodsId forKey:@"saleProductId"];
                [tempMutableDic setObject:goodsModel.goodsNumber forKey:@"cartNum"];
                if (!isEmpty(goodsModel.seckillActivityId)) {
                    [tempMutableDic setObject:goodsModel.seckillActivityId forKey:@"actId"];
                }
                [tempArr addObject:tempMutableDic];
            }
        }
    }];
    return [tempArr copy];
}

- (NSArray *)selectedGoodsIdArr {
    NSMutableArray *tempSelectedIdArrs = [NSMutableArray arrayWithCapacity:self.goodsShopCartDictionary.count];
    [self.goodsShopCartDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        GoodsModel *goodsModel = (GoodsModel *)obj;
        NSString *goodsId = (NSString *)key;
        if (goodsModel.selected) {
            if ([self isValidateCanbeBuyOfGoodsModel:goodsModel]) {
                [tempSelectedIdArrs addObject:goodsId];
            }
        }
    }];
    return [tempSelectedIdArrs copy];

}

- (NSArray *)selectedGoodsProductIdArr {

    NSMutableArray *tempSelectedProudctIdArrs = [NSMutableArray arrayWithCapacity:self.goodsShopCartDictionary.count];
    [self.goodsShopCartDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        GoodsModel *goodsModel = (GoodsModel *)obj;
        if (goodsModel.selected) {
            [tempSelectedProudctIdArrs addObject:goodsModel.productId];
        }
    }];
    return [tempSelectedProudctIdArrs copy];

}

- (NSArray *)selectedGoods {
    NSMutableArray *tempSelectedGoodArrs = [NSMutableArray arrayWithCapacity:self.goodsShopCartDictionary.count];
    [self.goodsShopCartDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        GoodsModel *goodsModel = (GoodsModel *)obj;
        if (goodsModel.selected) {
            [tempSelectedGoodArrs addObject:goodsModel];
        }
    }];
    return [tempSelectedGoodArrs copy];

}


@end
