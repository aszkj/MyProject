//
//  CommunityDataManager+switchCommuntyOrSelfTakeStore.h
//  YilidiBuyer
//
//  Created by mm on 16/12/7.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "CommunityDataManager.h"

typedef NS_ENUM(NSInteger,SwitchCommunityOrSelfTakeBackStatus) {
    NeedNotDoAnything,//什么都不做
    NormalSwitch,//正常流程切换
    OnlyNeedChangeHomeTopShipWayDisplay,//只需要改变首页顶部配送方式的显示
};

typedef void(^SwitchCommunityOrSelfTakeBackStatusBlock)(SwitchCommunityOrSelfTakeBackStatus backStatus, id communityOrStore);

@interface CommunityDataManager (switchCommuntyOrSelfTakeStore)

- (void)switchToCommunity:(CommunityModel *)communtiModel
          backStatusBlock:(SwitchCommunityOrSelfTakeBackStatusBlock)backStatusBlock;
- (void)switchToSelfTakeStore:(StoreModel *)storeModel
              backStatusBlock:(SwitchCommunityOrSelfTakeBackStatusBlock)backStatusBlock;
@end
