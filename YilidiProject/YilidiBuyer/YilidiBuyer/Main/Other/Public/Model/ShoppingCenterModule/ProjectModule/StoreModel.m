//
//  StoreModel.m
//  YilidiBuyer
//
//  Created by yld on 16/6/11.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "StoreModel.h"
#import "DateManager.h"
#import "NSMutableDictionary+safeSet.h"


@implementation StoreModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.modelOriginalDic = dic;
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
        self.storeScore = [dic[@"storeScore"] floatValue];
        self.hotline = dic[@"hotline"];
        self.storeBusinessDisplayTime = [NSString stringWithFormat:@"%@-%@",self.storeBusinessBeginTime,self.storeBusinessEndTime];
    }
    return self;
}

-(NSDictionary *)modelDic {
    
    NSMutableDictionary *storeDic = [NSMutableDictionary dictionaryWithCapacity:0];
    DicSaveSetObject(storeDic, @"storeId", @(self.storeId.longLongValue));
    DicSaveSetObject(storeDic, @"storeName", self.storeName);
    DicSaveSetObject(storeDic, @"businessHoursBegin", self.storeBusinessBeginTime);
    DicSaveSetObject(storeDic, @"businessHoursEnd", self.storeBusinessEndTime);
    DicSaveSetObject(storeDic, @"storeStatus", self.storeStatus);
    DicSaveSetObject(storeDic, @"transCostAmount", self.transCostAmount);
    DicSaveSetObject(storeDic, @"addressDetail", self.storeAdress);
    DicSaveSetObject(storeDic, @"deliveryTimeNote", self.deliveryTimeNote);
    DicSaveSetObject(storeDic, @"pickUpTimeNote", self.pickUpTimeNote);
    DicSaveSetObject(storeDic, @"cityName", self.cityName);
    DicSaveSetObject(storeDic, @"hotline", self.hotline);
    return self.modelOriginalDic;
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
