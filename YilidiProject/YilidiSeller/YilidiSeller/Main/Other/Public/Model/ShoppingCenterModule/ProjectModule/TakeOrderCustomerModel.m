//
//  TakeOrderCustomerModel.m
//  YilidiSeller
//
//  Created by yld on 16/7/6.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "TakeOrderCustomerModel.h"

@implementation TakeOrderCustomerModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.customerName = dic[@"consignee"];
        self.customerPhoneNumber = dic[@"consMobile"];
        self.customerAdress = dic[@"consAddress"];
        self.customerDistanceAwayFromYou = dic[@"distance"];
        self.customerLatitude = dic[@"latitude"];
        self.customerLongtitude = dic[@"longitude"];
    }
    return self;
}


@end
