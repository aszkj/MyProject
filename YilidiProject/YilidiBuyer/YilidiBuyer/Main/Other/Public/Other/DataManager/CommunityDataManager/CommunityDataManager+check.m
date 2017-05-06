//
//  CommunityDataManager+check.m
//  YilidiBuyer
//
//  Created by mm on 16/12/7.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "CommunityDataManager+check.h"
#import "GlobleConst.h"

@implementation CommunityDataManager (check)

- (BOOL)hasRelevancedStoreForCommunity:(CommunityModel *)communityModel {

    BOOL hasCommunityRelevanceStore = YES;
    if (isEmpty(communityModel)) {
        return NO;
    }
    
    if (isEmpty(communityModel.communityStore)) {
        hasCommunityRelevanceStore = NO;
    }else {
        if (isEmpty(communityModel.communityStore.storeId)) {
            hasCommunityRelevanceStore = NO;
        }else {
            hasCommunityRelevanceStore = YES;
        }
    }
    return hasCommunityRelevanceStore;
}


- (BOOL)isInCurrentStoreShipRangeForCommunity:(CommunityModel *)communityModel {
    
    if (isEmpty(kCommunityStoreId)) {//特殊情况，当前店铺为空，返回yes
        return YES;
    }else {
        if ([self hasRelevancedStoreForCommunity:communityModel]) {
            if (![communityModel.communityStore.storeId isEqualToString:kCommunityStoreId]) {
                return YES;
            }else{
                return NO;
            }
        }else {
            return NO;
        }
    }
}




@end
