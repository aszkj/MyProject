//
//  CommunityDataManager+switchCommuntyOrSelfTakeStore.m
//  YilidiBuyer
//
//  Created by mm on 16/12/7.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "CommunityDataManager+switchCommuntyOrSelfTakeStore.h"
#import "CommunityDataManager+check.h"
#import "GlobleConst.h"

@implementation CommunityDataManager (switchCommuntyOrSelfTakeStore)

- (void)switchToCommunity:(CommunityModel *)communtiModel
           backStatusBlock:(SwitchCommunityOrSelfTakeBackStatusBlock)backStatusBlock{
    
    BOOL newCommunityHasRelevancedStore = [[CommunityDataManager sharedManager] hasRelevancedStoreForCommunity:communtiModel];
    
    if (isEmpty(kCommunityStoreId)) {//当前小区没有关联店铺
        if (!newCommunityHasRelevancedStore) {//新小区也没有关联店铺
            //什么都不做
            backStatusBlock(NeedNotDoAnything,communtiModel);
        }else {
            //正常流程切换
            backStatusBlock(NormalSwitch,communtiModel);
        }
    }else {
        if (!newCommunityHasRelevancedStore) {
            //正常流程切换，
            backStatusBlock(NormalSwitch,communtiModel);
        }else {//两个都关联了店铺
            if ([communtiModel.communityId isEqualToString:kCommunityId]) {//切换到了同一个小区
                if (kCurrentShipWay == ShipWay_DeliveryGoodsHome) {//之前本来就是送货上门
                    //什么都不做
                    backStatusBlock(NeedNotDoAnything,communtiModel);
                }else if (kCurrentShipWay == ShipWay_SelfTake){//之前是自提
                    //只需要将首页顶部显示方式改为自提的显示方式
                    backStatusBlock(OnlyNeedChangeHomeTopShipWayDisplay,communtiModel);
                }
            }else {
                //正常流程切换，
                backStatusBlock(NormalSwitch,communtiModel);
            }
        }
    }
}

- (void)switchToSelfTakeStore:(StoreModel *)storeModel
           backStatusBlock:(SwitchCommunityOrSelfTakeBackStatusBlock)backStatusBlock{
    
    //切换自提店铺的时候，传过来的storeModel肯定是存在的
    if (isEmpty(kCommunityStoreId)) {//当前小区没有关联店铺
        //正常流程切换
        backStatusBlock(NormalSwitch,storeModel);
    }else {
        if ([storeModel.storeId isEqualToString:kCommunityStoreId]) {//切换到了同一个店铺
            if (kCurrentShipWay == ShipWay_SelfTake) {//之前本来就是自提
                //什么都不做
                backStatusBlock(NeedNotDoAnything,storeModel);
            }else if (kCurrentShipWay == ShipWay_DeliveryGoodsHome){//之前是送货上门
                //只需要将首页顶部显示方式改为送货上门的显示方式
                backStatusBlock(OnlyNeedChangeHomeTopShipWayDisplay,storeModel);
            }
        }else {
            //正常流程切换，
            backStatusBlock(NormalSwitch,storeModel);
        }
    }
}




@end
