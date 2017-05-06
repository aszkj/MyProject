//
//  StoreModel.m
//  YilidiBuyer
//
//  Created by yld on 16/6/11.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "StoreModel.h"
#import "DateManager.h"

@implementation StoreModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.storeId = [dic[@"storeId"] stringValue];
        self.storeName = dic[@"storeName"];
        self.storeBusinessBeginTime = dic[@"businessHoursBegin"];
        self.storeBusinessEndTime = dic[@"businessHoursEnd"];
        self.deduceTransCostAmount = dic[@"deduceTransCostAmount"];
        self.transCostAmount = dic[@"transCostAmount"];
        self.storeStatus = dic[@"storeStatus"];
        self.storeAdress = dic[@"addressDetail"];
        self.deliveryTimeNote = dic[@"deliveryTimeNote"];
        self.pickUpTimeNote = dic[@"pickUpTimeNote"];
        self.cityName = dic[@"cityName"];
        self.hotline = dic[@"hotline"];
        self.storeBusinessDisplayTime = [NSString stringWithFormat:@"%@-%@",self.storeBusinessBeginTime,self.storeBusinessEndTime];
        
    }
    return self;
}

-(NSString *)storeBeginShipTime {
    NSString *beginShipTime = [[DateManager sharedManager] afterAnHourTimeWithTheBasicTime:self.storeBusinessBeginTime];
    if (beginShipTime.length < 8) {
        return @"09:34";
    }else {
        return [beginShipTime substringWithRange:NSMakeRange(beginShipTime.length-8, 5)];
    }
}


-(NSInteger)storeOnTheBussinessTime {

    return [[DateManager sharedManager] currentDateInRangeFromBeginTime:self.storeBusinessBeginTime endTime:self.storeBusinessEndTime];

}
@end
