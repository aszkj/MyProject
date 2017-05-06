//
//  OrderDetailModel.m
//  YilidiSeller
//
//  Created by yld on 16/5/23.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "MerchantOrderDetailModel.h"
#import "GoodsModel.h"


@implementation MerchantOrderDetailModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.orderNo = dic[@"saleOrderNo"];
        self.orderStatusStr = dic[@"statusCodeName"];
        self.orderStatusNumber = dic[@"statusCode"];
        self.statusDesc = dic[@"statusDesc"];
        self.orderNote = dic[@"note"];
        self.buyerMobile = dic[@"buyerMobile"];
        self.orderPayTime = dic[@"payTime"];
        self.shipWayNumber = dic[@"deliveryModeCode"];
        self.bestTime = dic[@"bestTime"];
        self.acceptTime = dic[@"acceptTime"];
        self.finishTime = dic[@"finishTime"];
        self.cancelTime = dic[@"cancelTime"];
        self.orderCreateTime = dic[@"createTime"];
        self.shipTime = dic[@"deliveryTime"];
        self.recieveCode = dic[@"receiveNo"];
        self.payWayNumber = dic[@"payTypeCode"];
        self.payWayStr = dic[@"payTypeName"];
        self.orderGoodsTotalCount = dic[@"settleProductCount"];
        self.orderGoodsCount = dic[@"orderCount"];
        self.totalAmount = dic[@"totalAmount"];
        self.totalAmount = @(self.totalAmount.floatValue / 1000);
        self.perfectAmount = dic[@"preferentialAmt"];
        self.perfectAmount = @(self.perfectAmount.floatValue / 1000);
        self.shipAmount = dic[@"transferFee"];
        self.deliveryModeCode = dic[@"deliveryModeCode"];
        self.deliveryModeName = dic[@"deliveryModeName"];
        self.shipAmount = @(self.shipAmount.floatValue / 1000);
        self.orderGoodsAmount = dic[@"payableAmount"];
        self.orderGoodsAmount = @(self.orderGoodsAmount.floatValue / 1000);
        self.goodsSettleAmount = dic[@"settleTotalAmount"];
        self.goodsSettleAmount = @(self.goodsSettleAmount.floatValue / 1000);
        [self _setOrderStatus];
        NSDictionary *orderCustomerInfo = dic[@"consigneeAddress"];
        if (!isEmpty(orderCustomerInfo)) {
            self.takeOrderCustomerInfo = [[TakeOrderCustomerModel alloc] initWithDefaultDataDic:orderCustomerInfo];
        }
        NSArray *orderGoods = dic[@"saleOrderItemList"];
        if (!isEmpty(orderGoods)) {
            self.orderGoods = [GoodsModel objectOrderDetailGoodsModelWithGoodsArr:orderGoods];
        }
        NSArray *orderSettleAcountGoods = dic[@"saleOrderItemSettleList"];
        if (!isEmpty(orderSettleAcountGoods)) {
            self.orderSettleGoodsArr = [GoodsModel objectOrderSettleGoodsModelWithGoodsArr:orderSettleAcountGoods];
        }
        
    }
    return self;
}

- (void)setDeliveryModeCode:(NSNumber *)deliveryModeCode {
    if (deliveryModeCode.integerValue == 1) {
        self.orderShipWay = ShipWay_DeliveryGoodsHome;
    }else if (deliveryModeCode.integerValue == 2) {
        self.orderShipWay = ShipWay_SelfTake;
    }
}

- (void)_setOrderStatus {
    
    NSString *orderStatusStr = nil;
      switch (self.orderStatusNumber.integerValue) {
        case 1:
            self.orderStatus = OrderStatus_ReadyToPay;
            orderStatusStr = @"未付款";
            break;
        case 2:
            self.orderStatus = OrderStatus_ReadyToTakeOrder;
            orderStatusStr = @"待接单";
            break;
        case 3:
            self.orderStatus = OrderStatus_ReadyToDeliveryGoods;
            orderStatusStr = @"未发货";
            break;
        case 4:
            self.orderStatus = OrderStatus_ReadyToEnsureCustomerRecieveGoods;
            orderStatusStr = self.orderShipWay == ShipWay_DeliveryGoodsHome ? @"配送中":@"待提货";
            break;
        case 5:
            self.orderStatus = OrderStatus_HasFinished;
            orderStatusStr = @"已完成";
            break;
        case 6:
            self.orderStatus = OrderStatus_HasComment;
            orderStatusStr = @"已评价";
            break;
        case 7:
            self.orderStatus = OrderStatus_HasCanceled;
            orderStatusStr = @"已取消";
            break;
        case 8:
            self.orderStatus = OrderStatus_Refunding;
            orderStatusStr = @"退款中";
            break;
        case 9:
            self.orderStatus = OrderStatus_HasRefunded;
            orderStatusStr = @"退款完成";
            break;
        case 10:
            self.orderStatus = OrderStatus_HasRefundedFailed;
            orderStatusStr = @"退款失败";
            break;
        default:
            break;
    }
    self.orderStatusStr = orderStatusStr;
    
}

@end
