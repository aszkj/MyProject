//
//  DLPayResultPageModel.m
//  YilidiBuyer
//
//  Created by yld on 16/8/5.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLPayResultPageModel.h"
#import "StoreModel.h"

@implementation DLPayResultPageModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.saleOrderNo = dic[@"saleOrderNo"];
        self.deliveryModeCode = dic[@"deliveryModeCode"];
        self.paidAmount = dic[@"paidAmount"];
        self.payTypeName = dic[@"payTypeName"];
        self.deliveryModeName = dic[@"deliveryModeName"];
        self.deliveryTimeNote = dic[@"deliveryTimeNote"];
        self.receiveCode = dic[@"receiveCode"];
        self.storeInfo = [[StoreModel alloc] initWithDefaultDataDic:dic[@"storeInfo"]];;
        self.preferentialAmt = dic[@"preferentialAmt"];
    }
    return self;
}


@end
