//
//  CommunityDataManager+check.h
//  YilidiBuyer
//
//  Created by mm on 16/12/7.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "CommunityDataManager.h"

@interface CommunityDataManager (check)

- (BOOL)hasRelevancedStoreForCommunity:(CommunityModel *)communityModel;

- (BOOL)isInCurrentStoreShipRangeForCommunity:(CommunityModel *)communityModel;

@end
