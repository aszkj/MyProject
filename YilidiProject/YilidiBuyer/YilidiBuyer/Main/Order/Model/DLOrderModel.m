//
//  DLOrderModel.m
//  YilidiBuyer
//
//  Created by yld on 16/5/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderModel.h"
#import "DLHomeGoodsModel.h"

@implementation DLOrderModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {

    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.orderNo = dic[@"orderNo"];
        self.totalAmount = dic[@"totalAmount"];
        self.payAmount = dic[@"payAmount"];
        self.goodsTotalNumber = dic[@"totalNumber"];
        self.couponId = dic[@"couponId"];
        self.couponAmount = dic[@"couponAmount"];
        self.deliveryFee = dic[@"deliveryFee"];
        self.orderStatusNumber = dic[@"orderStatus"];
        self.orderGoods = [DLHomeGoodsModel objectGoodsModelWithGoodsArr:dic[@"goods"]];
        self.receiveTimeModel = [[DLReceiveTimeModel alloc] initWithDefaultDataDic:dic[@"receiveTime"]];
    }
    return self;
}

- (void)_setOrderStatusByOrderStatusNumber {
    OrderStatus orderStatus = OrderStatus_ReadyToPay;
    NSString *orderStatusStr = nil;
    switch (self.orderStatusNumber.integerValue) {
        case 10:
        {
            orderStatus = OrderStatus_ReadyToPay;
            orderStatusStr = @"待付款";
            break;
        }
        case 30:
        {
            orderStatus = OrderStatus_ReadyToRecieveGoods;
            orderStatusStr = @"待收货";
            break;
        }
        case 40:
        {
            orderStatus = OrderStatus_HasFinished;
            orderStatusStr = @"交易完成";
            break;
        }
        case 50:
        {
            orderStatus = OrderStatus_HasCanceled;
            orderStatusStr = @"交易取消";
            break;
        }
        default:
            break;
    }
    _orderStatus = orderStatus;
    _orderStatusStr = orderStatusStr;
}

- (void)setOrderStatusNumber:(NSNumber *)orderStatusNumber {
    _orderStatusNumber = orderStatusNumber;
    [self _setOrderStatusByOrderStatusNumber];
    
}

@end
