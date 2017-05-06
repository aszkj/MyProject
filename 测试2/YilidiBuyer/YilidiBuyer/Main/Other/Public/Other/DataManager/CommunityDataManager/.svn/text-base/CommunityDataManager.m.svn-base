//
//  CommunityDataManager.m
//  YilidiBuyer
//
//  Created by yld on 16/6/11.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "CommunityDataManager.h"
#import "ProjectRelativeDefineNotification.h"
#import "TMCache.h"

static NSString *currentCommunityModelCacheKey = @"currentCommunityModelCacheKey";
static NSString *currentStoreModelCacheKey = @"currentStoreModelCacheKey";


static CommunityDataManager *_communityDataManager = nil;

@implementation CommunityDataManager

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _communityDataManager = [[CommunityDataManager alloc] init];
        
    });
    return _communityDataManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
//        [self _registerSwitchCommunityNotification];
        self.selectedShipWay = ShipWay_DeliveryGoodsHome;
        [self _inicCommunityCache];
    }
    return self;
}

#pragma mark -------------------Private Method----------------------
- (void)_registerSwitchCommunityNotification {
    
    [kNotification addObserver:self selector:@selector(_observeSwitchCommunity:) name:KNotificationSwitchCommunity object:nil];
}

- (void)_inicCommunityCache {
    CommunityModel *lastCommunityModel = (CommunityModel *)[[TMCache sharedCache] objectForKey:currentCommunityModelCacheKey];
    _communityModel = lastCommunityModel;
    StoreModel *lastStoreModel = (StoreModel *)[[TMCache sharedCache] objectForKey:currentStoreModelCacheKey];
    _currentStore = lastStoreModel;

}

- (void)_doCommunityModelCache {
    if (isEmpty(self.communityModel)) {
        return;
    }
    [[TMCache sharedCache] setObject:self.communityModel forKey:currentCommunityModelCacheKey];
}

- (void)_doStoreModelCache {
    if (isEmpty(self.currentStore)) {
        return;
    }
    [[TMCache sharedCache] setObject:self.currentStore forKey:currentStoreModelCacheKey];
}

- (void)_setCommunityConfigure {
    self.hasLocatedOrSelectedCommunity = YES;
    _currentStore = self.communityModel.communityStore;
    self.selectedShipWay = ShipWay_DeliveryGoodsHome;
    [self _doStoreModelCache];
    [self _doCommunityModelCache];
}

- (void)_setCurrentStoreConfigure {
    self.selectedShipWay = ShipWay_SelfTake;
    [self _doStoreModelCache];
}

#pragma mark -------------------Notification Method----------------------
- (void)_observeSwitchCommunity:(NSNotification *)notification {
    CommunityModel *newCommunityModel = notification.object;
    if (![self.communityModel.communityId isEqualToString:newCommunityModel.communityId]) {
        self.communityModel = newCommunityModel;
    }
}

#pragma mark -------------------Setter/Getter Method----------------------
- (void)setCommunityModel:(CommunityModel *)communityModel {
    _communityModel = communityModel;
    [self _setCommunityConfigure];
}

- (void)setCurrentStore:(StoreModel *)currentStore {
    _currentStore = currentStore;
    [self _setCurrentStoreConfigure];
}

@end
