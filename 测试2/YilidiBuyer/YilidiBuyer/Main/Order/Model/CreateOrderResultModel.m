//
//  CreateOrderResultModel.m
//  YilidiBuyer
//
//  Created by yld on 16/8/5.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "CreateOrderResultModel.h"

@implementation CreateOrderResultModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.orderNo = dic[@"saleOrderNo"];
        self.orderShipWayNumber = dic[@"deliveryModeCode"];
        self.orderShipWayName = dic[@"deliveryModeName"];
        self.orderPaidAmount = dic[@"paidAmount"];
        self.recieveCode = dic[@"receiveCode"];
        self.deliveryCodeNote = dic[@"deliveryTimeNote"];
    }
    return self;
}


@end
