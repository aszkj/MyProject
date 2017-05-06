//
//  OrderListModel.m
//  YilidiBuyer
//
//  Created by yld on 16/5/23.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "OrderListModel.h"
#import "GoodsModel.h"

@implementation OrderListModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.orderNo = dic[@"saleOrderNo"];
        self.totalAmount = dic[@"totalAmount"];
        self.orderStatusNumber = dic[@"statusCode"];
        self.orderStoreName = dic[@"storeName"];
        self.orderStatusStr = dic[@"statusCodeName"];
        [self setOrderShipWayWithOrderShipNumber:dic[@"deliveryModeCode"]];
        self.orderGoods = [GoodsModel objectOrderGoodsModelWithGoodsArr:dic[@"orderImageList"]];
        [self setOrderStatus];
    }
    return self;
}

@end

@implementation OrderListModel (objectArr)

+ (NSArray *)objectArrWithOrderArr:(NSArray *)orderArr {
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:orderArr.count];
    for (NSDictionary *dic in orderArr) {
        OrderListModel *model = [[OrderListModel alloc] initWithDefaultDataDic:dic];
        [tempArr addObject:model];
    }
    return [tempArr copy];
}

- (void)setOrderStatus {
    
    switch (self.orderStatusNumber.integerValue) {
        case 1:
            self.orderStatus = OrderStatus_ReadyToPay;
            break;
        case 2:
            self.orderStatus = OrderStatus_HasPayedWaitMerchantToTakeOrder;
            break;
        case 3:
            self.orderStatus = OrderStatus_HasPayedWaitMerchantToDeliveryGoods;
            break;
        case 4:
            self.orderStatus = OrderStatus_MerchantHasDeliveredGoodsConfiureRecieveGoods;
            break;
        case 5:
            self.orderStatus = OrderStatus_HasFinished;
            break;
        case 6:
            self.orderStatus = OrderStatus_HasComment;
            break;
        case 7:
            self.orderStatus = OrderStatus_HasCanceled;
            break;
        case 8:
            self.orderStatus = OrderStatus_Refunding;
            break;
        case 9:
            self.orderStatus = OrderStatus_HasRefunded;
            break;
        default:
            break;
    }
    
}

- (void)setOrderShipWayWithOrderShipNumber:(NSNumber *)orderShipWayNumber{
    if (isEmpty(orderShipWayNumber)) {
        self.orderShipWay = ShipWay_DeliveryGoodsHome;
        return;
    }
    
    if (orderShipWayNumber.integerValue == 1) {
        self.orderShipWay = ShipWay_DeliveryGoodsHome;
    }else if (orderShipWayNumber.integerValue == 2) {
        self.orderShipWay = ShipWay_SelfTake;
    }
}




@end