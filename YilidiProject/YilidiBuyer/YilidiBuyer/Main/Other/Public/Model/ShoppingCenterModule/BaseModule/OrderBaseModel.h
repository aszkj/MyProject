//
//  OrderModel.h
//  YilidiBuyer
//
//  Created by yld on 16/5/23.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface OrderBaseModel : BaseModel

typedef enum : NSUInteger {
    OrderStatus_ReadyToPay,
    OrderStatus_ReadyToRecieveGoods,
    OrderStatus_ReadyToComment,
    OrderStatus_HasComment,
    OrderStatus_HasPayedWaitMerchantToTakeOrder,       //已付款待卖家接单
    OrderStatus_HasPayedWaitMerchantToDeliveryGoods,   //待卖家发货，未发货
    OrderStatus_MerchantHasDeliveredGoodsConfiureRecieveGoods,//卖家已发货，确认收货
    OrderStatus_HasCanceled,
    OrderStatus_HasFinished,
    OrderStatus_Refunding,
    OrderStatus_HasRefunded,
    OrderStatus_HasRefundedFailed,
} OrderStatus;
/**
 *  订单编号
 */
@property (nonatomic,copy)NSString *orderNo;
/**
 *  订单总价
 */
@property (nonatomic,strong)NSNumber *totalAmount;
/**
 *  订单状态数字
 */
@property (nonatomic,strong)NSNumber *orderStatusNumber;
/**
 *订单状态类型
 */
@property (nonatomic,assign)OrderStatus orderStatus;
/**
 *  订单状态字符串
 */
@property (nonatomic,copy)NSString *orderStatusStr;
/**
 *  订单商品
 */
@property (nonatomic,copy)NSArray *orderGoods;
/**
 *  订单店铺名
 */
@property (nonatomic,copy)NSString *orderStoreName;

/**
 是否评价
 */
@property (nonatomic,assign) BOOL isOrderEvaluated;

@end
