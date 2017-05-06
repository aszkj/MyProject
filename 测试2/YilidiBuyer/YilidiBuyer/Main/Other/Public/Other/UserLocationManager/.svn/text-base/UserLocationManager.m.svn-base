//
//  UserLocationManager.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/7/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "UserLocationManager.h"
#import "CommunityModel.h"
#import "GlobleConst.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "NSDate+Utilities.h"

const NSInteger basiclocateInteralSeconds = 60 * 5;

static UserLocationManager *_userLocationManager = nil;

@interface UserLocationManager()

@property (nonatomic, strong)NSTimer *userLocationUpdateTimer;

@property (nonatomic, strong)NSDate *lastLeaveHomePageDate;

@property (nonatomic, assign)NSInteger locateInteralSeconds;

@property (nonatomic, assign)NSInteger timerLocateCount;

@property (nonatomic, assign)BOOL isfirstLocate;

@property (nonatomic,assign)CGFloat currentlatitude;

@property (nonatomic,assign)CGFloat currentlongtitude;


@end

@implementation UserLocationManager

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _userLocationManager = [[UserLocationManager alloc] init];
        
    });
    
    return _userLocationManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _locateInteralSeconds = basiclocateInteralSeconds;
        self.isfirstLocate = YES;
    }
    return self;
}

-(void)startUserLocationBackBlock:(BaiduLocationBlock)baiduLocationBlock
                       errorBlock:(BaiduLocationErrorBlock)errorblock{
    WEAK_SELF
    [[BaiduLocationManage shareManage] startLocationBackBlock:^(CLLocation *location,NSString *city) {
        weak_self.currentlatitude = location.coordinate.latitude;
        weak_self.currentlongtitude = location.coordinate.longitude;
        emptyBlock(baiduLocationBlock,location,city);
        if (!weak_self.isfirstLocate) {
            [weak_self _requestNearbyDefaultShopWithLogintitude:location.coordinate.longitude latitude:location.coordinate.latitude];
        }
    } errorBlock:^(NSError *error) {
        emptyBlock(errorblock,error);
    }];
}

- (void)_requestNearbyDefaultShopWithLogintitude:(CGFloat)longtitude latitude:(CGFloat)latitude {
    
    [AFNHttpRequestOPManager requestNearbyShopWithlongtitude:longtitude latitude:latitude block:^(id result, NSError *error) {
        CommunityModel *communityModel = [[CommunityModel alloc] initWithDefaultDataDic:result[EntityKey]];
        if (!isEmpty(communityModel)) {
            if (kCurrentShipWay == ShipWay_DeliveryGoodsHome) {
                if ([communityModel.communityId isEqualToString:kCommunityId]) {
                    return;
                }else{
                    emptyBlock(self.userLocationCommunityChangeBlcok,communityModel);
                }
            }else if (kCurrentShipWay == ShipWay_SelfTake) {
                if (![kCommunityStoreId isEqualToString:communityModel.communityStore.storeId]) {
                    emptyBlock(self.userLocationCommunityChangeBlcok,communityModel);
                }
            }
        }else{
            if (kCurrentShipWay == ShipWay_DeliveryGoodsHome) {
                if (isEmpty(kCommunityId)) {
                    return;
                }
                emptyBlock(self.userLocationCommunityChangeBlcok,communityModel);
            }else if (kCurrentShipWay == ShipWay_SelfTake) {
                if (!isEmpty(kCommunityStoreId)) {
                    emptyBlock(self.userLocationCommunityChangeBlcok,communityModel);
                }
            }
        }
    }];
}

- (void)_beginTimerLocate {
    self.userLocationUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scheduledTimer) userInfo:nil repeats:YES];
    self.timerLocateCount = 0;
}

- (void)_endTimerLocate {
    [self.userLocationUpdateTimer invalidate];
    self.userLocationUpdateTimer = nil;
    self.timerLocateCount = 0;
    
}

- (void)scheduledTimer {
    self.timerLocateCount ++;
    if (self.timerLocateCount % self.locateInteralSeconds == 0) {
        [self _relocatedUserLocation];
    }
}

- (void)_relocatedUserLocation {
    self.isfirstLocate = NO;
    [self startUserLocationBackBlock:nil errorBlock:nil];
}

- (void)_dealLastEnterHomePageTime {
    NSDate *currentEnterHomeDate = [NSDate date];
    if (!self.lastLeaveHomePageDate) {
        return;
    }else {
        NSInteger lasteLeaveHomePageMinute = self.lastLeaveHomePageDate.hour * 60 + self.lastLeaveHomePageDate.minute;
        NSInteger currentEnterHomePageMinute = currentEnterHomeDate.hour * 60 + currentEnterHomeDate.minute;
        if (currentEnterHomePageMinute - lasteLeaveHomePageMinute >=  self.locateInteralSeconds/60) {
            [self _relocatedUserLocation];
        }
    }

}

- (void)setEnterHomePage:(BOOL)enterHomePage {
    _enterHomePage = enterHomePage;
    [self _dealLastEnterHomePageTime];
    [self _beginTimerLocate];
}

- (void)setLeaveHomePage:(BOOL)leaveHomePage {
    _leaveHomePage = leaveHomePage;
    self.lastLeaveHomePageDate = [NSDate date];
    [self _endTimerLocate];
}

- (void)setUserSwitchedCommuntiByHand:(BOOL)userSwitchedCommuntiByHand {
    _userSwitchedCommuntiByHand = userSwitchedCommuntiByHand;
    self.locateInteralSeconds = 2 * basiclocateInteralSeconds;
}


@end
