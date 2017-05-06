//
//  DLCouponModel.m
//  YilidiBuyer
//
//  Created by mm on 16/10/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLCouponModel.h"
#import "NSString+Teshuzifu.h"
#import "NSDate+Addition.h"

@implementation DLCouponModel

- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.userCope = dic[@"useScope"];
        self.ticketDescription = dic[@"ticketDescription"];
        self.beginTime = dic[@"beginTime"];
        self.beginTime = [self.beginTime castHourMinuteSecondeStrForTheTimeStr];
        self.ticketId = [dic[@"ticketId"] stringValue];
        self.endTime = dic[@"endTime"];
        self.endTime = [self.endTime castHourMinuteSecondeStrForTheTimeStr];
        self.ticketType = [dic[@"ticketType"] integerValue];
        self.ticketAmount = [dic[@"ticketAmount"] integerValue]/1000;
        self.ticketTypeName = dic[@"ticketTypeName"];
        self.ticketStatusName = dic[@"ticketStatusName"];
        self.wouldUse = [dic[@"wouldUse"] integerValue];

    }
    return self;
}

-(long)validTicketEndTime {
    return (long)[NSDate subCurrentDateWithDateString:self.endTime];
}



@end
