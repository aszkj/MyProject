//
//  SeckillActivityModel.m
//  YilidiBuyer
//
//  Created by yld on 16/8/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "SeckillActivityModel.h"
#import "NSDate+Addition.h"

@implementation SeckillActivityModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.activityId = [dic[@"actId"] stringValue];
        self.activityName = dic[@"actName"];
        self.activityBeginTime = dic[@"beginTime"];
        self.activityEndTime = dic[@"endTime"];
        self.serverSystemTime = dic[@"systemTime"];
        self.activityStatusName = dic[@"statusName"];
    }
    return self;
}

- (void)setSeckillActivityStatus:(SeckillActivityStatus)seckillActivityStatus {
    _seckillActivityStatus = seckillActivityStatus;
    [self _ensureSeckillActivityStatusStr];
}

- (void)_ensureSeckillActivityStatusStr {
    NSString *seckillActivityStatusStr = nil;
    switch (self.seckillActivityStatus) {
        case SeckillActivityStatus_hasBegan:
            seckillActivityStatusStr = @"已开始";
            break;
        case SeckillActivityStatus_crazySaling:
            seckillActivityStatusStr = @"疯抢中";
            break;
        case SeckillActivityStatus_soonBegin:
            seckillActivityStatusStr = @"即将开始";
            break;
        default:
            break;
    }
    self.activityStatusName = seckillActivityStatusStr;
}

@end

@implementation SeckillActivityModel (extral)

-(long long)beginTimeInterval {
    
    return (long long)[NSDate subCurrentDateWithDateString:self.activityBeginTime];
    
}

-(long long)endTimeInterval {

    return (long long)[NSDate subCurrentDateWithDateString:self.activityEndTime];

}


@end