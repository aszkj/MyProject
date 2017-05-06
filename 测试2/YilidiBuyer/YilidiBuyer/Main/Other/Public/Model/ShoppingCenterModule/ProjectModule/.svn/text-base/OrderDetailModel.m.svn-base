//
//  OrderDetailModel.m
//  YilidiBuyer
//
//  Created by yld on 16/5/23.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "OrderDetailModel.h"

@implementation OrderDetailModel

- (void)setDefaultDataDic:(NSDictionary *)dic {

    self.orderStatusNumber = dic[@"statusCode"];
    [self _setOrderStatusByOrderStatusNumber];
}

- (void)_setOrderStatusByOrderStatusNumber {
    OrderStatus orderStatus = OrderStatus_ReadyToPay;
    switch (self.orderStatusNumber.integerValue) {
        case 1:
        {
            orderStatus = OrderStatus_ReadyToPay;
            break;
        }
        case 2:
        {
            orderStatus = OrderStatus_ReadyToRecieveGoods;
            break;
        }
        case 3:
        {
            orderStatus = OrderStatus_ReadyToComment;
            break;
        }
        case 4:
        {
            orderStatus = OrderStatus_MerchantHasDeliveredGoodsConfiureRecieveGoods;
            break;
        }
        case 5:
        {
            orderStatus = OrderStatus_HasFinished;
            break;
        }
        case 6:
        {
//            orderStatus = OrderStatus_Refund;
            break;
        }
        case 7:
        {
            orderStatus = OrderStatus_HasCanceled;
            break;
        }
        case 8:
        {
            orderStatus = OrderStatus_Refunding;
            break;
        }
           
        case 9:
        {
            orderStatus = OrderStatus_HasRefunded;
            break;
        }
            
        default:
            break;
    }
    self.orderStatus = orderStatus;
}

@end
