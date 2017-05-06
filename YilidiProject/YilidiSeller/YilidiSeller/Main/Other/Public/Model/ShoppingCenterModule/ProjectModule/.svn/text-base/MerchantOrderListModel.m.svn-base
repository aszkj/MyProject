//
//  OrderListModel.m
//  YilidiSeller
//
//  Created by yld on 16/5/23.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "MerchantOrderListModel.h"
#import "GoodsModel.h"

@implementation MerchantOrderListModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.orderNo = dic[@"saleOrderNo"];
        self.totalAmount = dic[@"payableAmount"];
        self.totalAmount = @(self.totalAmount.floatValue / 1000);
        self.orderPayTime = dic[@"payTime"];
        self.orderCreateTime = dic[@"createTime"];
        self.deliveryModeCode = dic[@"deliveryModeCode"];
        self.buyerMobile = dic[@"buyerMobile"];
        NSDictionary *orderCustomerInfo = dic[@"consigneeAddress"];
        if (!isEmpty(orderCustomerInfo)) {
            self.takeOrderCustomerInfo = [[TakeOrderCustomerModel alloc] initWithDefaultDataDic:orderCustomerInfo];
        }
    }
    return self;
}

@end

@implementation MerchantOrderListModel (objectArr)

+ (NSArray *)objectArrWithOrderArr:(NSArray *)orderArr {
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:orderArr.count];
    for (NSDictionary *dic in orderArr) {
        MerchantOrderListModel *model = [[MerchantOrderListModel alloc] initWithDefaultDataDic:dic];
        [tempArr addObject:model];
    }
    return [tempArr copy];
}

@end