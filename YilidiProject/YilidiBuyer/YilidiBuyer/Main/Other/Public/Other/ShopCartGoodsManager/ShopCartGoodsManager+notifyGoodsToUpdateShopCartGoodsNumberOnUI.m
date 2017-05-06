//
//  ShopCartGoodsManager+notifyGoodsToUpdateShopCartGoodsNumberOnUI.m
//  YilidiBuyer
//
//  Created by yld on 16/8/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsManager+notifyGoodsToUpdateShopCartGoodsNumberOnUI.h"
#import "ProjectRelativeMaco.h"
#import "ProjectRelativeKey.h"

@implementation ShopCartGoodsManager (notifyGoodsToUpdateShopCartGoodsNumberOnUI)

- (void)postNotificationOfDeleteGoodsIds:(NSArray *)deleteGoodsIds {
    for (NSString *goodsId in deleteGoodsIds) {
//        [self notifyTheGoods:goodsId added:NO toTheNewNumber:0];
        NSDictionary *postDic = @{
                                  KGoodsChangeGoodsNumberKey:@(0),
                                  KGoodsChangeIsAddKey:@(NO)};
        [kNotification postNotificationName:KGoodsIdNotificationNameWithGoodsId(goodsId) object:nil userInfo:postDic];

    }
}

- (void)notifyTheGoods:(GoodsModel *)goodsModel added:(BOOL)added toTheNewNumber:(NSInteger)newNumber{
    NSDictionary *postDic = @{
                              KGoodsChangeGoodsNumberKey:@(newNumber),
                              KGoodsChangeIsAddKey:@(added),
                              KGoodsModelKey:goodsModel};
    [kNotification postNotificationName:KGoodsIdNotificationNameWithGoodsId(goodsModel.goodsId) object:nil userInfo:postDic];
}


@end
