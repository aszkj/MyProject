//
//  DLGoodsdetailVC+shopCartAddDifferentGoodsTypeDeal.m
//  YilidiBuyer
//
//  Created by yld on 16/7/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGoodsdetailVC+shopCartAddDifferentGoodsTypeDeal.h"
#import "GlobleConst.h"
#import "ShopCartGoodsManager+shopCartInfo.h"

@implementation DLGoodsdetailVC (shopCartAddDifferentGoodsTypeDeal)

- (BOOL)currentCommunityStoreOnBussiness {
    if (!kCurrentCummunityStoreBusinessStatus) {
        [Util ShowAlertWithOnlyMessage:kAlertStoreClosed];
        return NO;
    }
    return YES;
}

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
    return kAlertDifferentGoodsToShopCart;
}

- (BOOL)dealPennyGoods {
    if (self.goodsModel.goodsType == GoodsType_NormalPennyGoods) {
        NSInteger nowGoodsCount = [[ShopCartGoodsManager sharedManager] goodsNumberOfGoodsModel:self.goodsModel];
        if (nowGoodsCount + 1 > KDennyGoodsLimitCount) {
            [Util ShowAlertWithOnlyMessage:kAlertBuyyingPennyGoods];
            return YES;
        }else {
            return NO;
        }
    }
    return NO;
}



@end
