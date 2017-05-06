//
//  SeckillActivityManager.m
//  YilidiBuyer
//
//  Created by yld on 16/8/24.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "SeckillActivityManager.h"
#import "ProjectRelativeKey.h"
#import "GlobleConst.h"
#import "SeckillActivityModel.h"
#import "NSDate+Addition.h"

@interface SeckillActivityManager()

@property (nonatomic, strong)SeckillActivityModel *currentCrazySaleModel;

/**
 *  第一次进入的本地时间
 */
@property (nonatomic, assign)long long firstEnterLocalTimeInterval;
/**
 *  第一次进入的服务器时间,以后每次计算都是以服务器时间为主==>服务器当前时间=（当前时间-第一次进入的本地时间）+ 第一次进入的服务器时间
 */
@property (nonatomic, assign)long long firstEnterServerTimeInterval;

@property (nonatomic, assign)BOOL isFirstRequestSeckillInfo;


@end

@implementation SeckillActivityManager

- (void)requestHomeSeckillActivityInfo{

    if (isEmpty(kCommunityStoreId)) {
        return;
    }
    NSDictionary *requestParam = @{KStoreIdKey:kCommunityStoreId};
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_GetHomeSeckillActivityInfo block:^(NSDictionary *resultDic, NSError *error) {
        
        self.currentCrazySaleModel = [[SeckillActivityModel alloc] initWithDefaultDataDic:resultDic[EntityKey]];
        if (!self.isFirstRequestSeckillInfo) {
            self.isFirstRequestSeckillInfo = YES;
            [self _initActivityInfo];
        }
        self.currentCrazySaleModel.leftCount = [self leftTimeInterVal];

    }];
}

- (void)_initActivityInfo {
    self.firstEnterLocalTimeInterval = [self currentTimeInterval];
    self.firstEnterServerTimeInterval = [NSDate subCurrentDateWithDateString:self.currentCrazySaleModel.serverSystemTime];
    [self _startCrazySaleCountDown];
    [self _registerAppEnterForeGroundNotification];
}

- (void)_registerAppEnterForeGroundNotification {
    [kNotification addObserver:self
                      selector:@selector(appEnterForeGround:)
                          name:UIApplicationDidBecomeActiveNotification object:nil];

}

- (void)_startCrazySaleCountDown {
    NSTimer *activityCountDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(crazySaleActivityCountDown) userInfo:nil repeats:YES];
    //滑动模式下让定时器继续工作
    [[NSRunLoop currentRunLoop] addTimer:activityCountDownTimer forMode:UITrackingRunLoopMode];
}

- (void)crazySaleActivityCountDown{
    self.currentCrazySaleModel.leftCount -- ;
    if (!self.currentCrazySaleModel.leftCount) {
        [self requestHomeSeckillActivityInfo];
    }
    emptyBlock(self.crazySaleActivityCountDonwBlock,self.currentCrazySaleModel.leftCount);
    
}
#pragma mark -------------------Notification Method----------------------
- (void)appEnterForeGround:(NSNotification *)info {
    if ([self leftTimeInterVal] > 0) {
        self.currentCrazySaleModel.leftCount = [self leftTimeInterVal];
    }else {
        [self requestHomeSeckillActivityInfo];
    }
}

#pragma mark -------------------Setter/Getter Method----------------------
- (long long)currentServerTime {
    long long goneTimeFromFirstEnter = [self currentTimeInterval] - self.firstEnterLocalTimeInterval;
    return self.firstEnterServerTimeInterval + goneTimeFromFirstEnter;
}

- (long long)leftTimeInterVal {
    long long currentServerActivityEndTimeInterval = [NSDate subCurrentDateWithDateString:self.currentCrazySaleModel.activityEndTime];
    long long currentserverTime = [self currentServerTime];
    return currentServerActivityEndTimeInterval - currentserverTime;
}

- (long long)currentTimeInterval {
    return (long long)[NSDate currentTimeInterval];
}

@end
