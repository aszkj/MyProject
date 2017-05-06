//
//  DLOrderModel.h
//  YilidiBuyer
//
//  Created by yld on 16/5/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"
#import "DLReceiveTimeModel.h"

typedef enum : NSUInteger {
    OrderStatus_ReadyToPay,
    OrderStatus_ReadyToRecieveGoods,
    OrderStatus_ReadyToComment,
    OrderStatus_HasCanceled,
    OrderStatus_HasFinished,
} OrderStatus;

@interface DLOrderModel : BaseModel

@property (nonatomic,copy)NSString *orderNo;

@property (nonatomic,strong)NSNumber *totalAmount;

@property (nonatomic,strong)NSNumber *payAmount;

@property (nonatomic,strong)NSNumber *goodsTotalNumber;

@property (nonatomic,strong)NSNumber *orderStatusNumber;

@property (nonatomic,assign)OrderStatus orderStatus;

@property (nonatomic,copy)NSString *orderStatusStr;
/**
 *  优惠券ID
 */
@property (nonatomic,strong)NSNumber *couponId;
/**
 *  优惠券金额
 */
@property (nonatomic,strong)NSNumber *couponAmount;

/**
 *  配送运费
 */
@property (nonatomic,strong)NSNumber *deliveryFee;

/**
 *  配送时间model
 */
@property (nonatomic,strong)DLReceiveTimeModel *receiveTimeModel;

/**
 *  订单商品
 */
@property (nonatomic,copy)NSArray *orderGoods;


@end
