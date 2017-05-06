//
//  DLGrabRedPacketGameInfoModel.m
//  YilidiBuyer
//
//  Created by mm on 16/10/28.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGrabRedPacketGameInfoModel.h"

@implementation DLGrabRedPacketGameInfoModel

- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.residueTimes = [dic[@"residueTimes"] integerValue];
        self.receivedRedEnvelopCount = [dic[@"receivedRedEnvelopeCount"] integerValue];
        NSDictionary *redEnvelopActivityInfo = dic[@"redEnvelopeActivityInfo"];
        if (!isEmpty(redEnvelopActivityInfo)) {
            self.activityId = redEnvelopActivityInfo[@"activityId"];
            self.activityRule = redEnvelopActivityInfo[@"activityRule"];
            self.maxJoinTimes = [redEnvelopActivityInfo[@"maxJoinTimes"] integerValue];
            self.maxTimePerTimes = [redEnvelopActivityInfo[@"maxTimePerTimes"] integerValue];
            self.maxCountPerTimes = [redEnvelopActivityInfo[@"maxCountPerTimes"] integerValue];
            self.interfaceInvokedProbability = [redEnvelopActivityInfo[@"interfaceInvokedProbability"] integerValue];
        }
    }
    return self;
}


@end
