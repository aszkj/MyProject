//
//  OrderModel.h
//  YilidiSeller
//
//  Created by yld on 16/5/23.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface OrderBaseModel : BaseModel

typedef enum : NSUInteger {
    OrderStatus_ReadyToPay,             //待付款,未付款
    OrderStatus_ReadyToRecieveGoods,    //待收货
    OrderStatus_ReadyToComment,         //待评价
    OrderStatus_ReadyToTakeOrder,       //待接单
    OrderStatus_ReadyToDeliveryGoods,   //待发货，未发货
    OrderStatus_ReadyToEnsureCustomerRecieveGoods,//配送中，待确认买家收货
    OrderStatus_HasCanceled,            //已取消
    OrderStatus_HasFinished,            //已完成
    OrderStatus_HasComment,             //已评价
    OrderStatus_Refunding,              //退款中
    OrderStatus_HasRefunded,            //退款完成
    OrderStatus_HasRefundedFailed             //退款失败
} OrderStatus;
/**
 *  订单编号
 */
@property (nonatomic,copy)NSString *orderNo;

/**
 *  商品金额
 */
@property (nonatomic,strong)NSNumber *orderGoodsAmount;
/**
 *  订单金额
 */
@property (nonatomic,strong)NSNumber *totalAmount;
/**
 *  配送金额
 */
@property (nonatomic,strong)NSNumber *shipAmount;
/**
 *  优惠金额
 */
@property (nonatomic,strong)NSNumber *perfectAmount;


/**
 *  订单商品数
 */
@property (nonatomic,strong)NSNumber *orderGoodsCount;

/**
 *  订单商品总数
 */
@property (nonatomic,strong)NSNumber *orderGoodsTotalCount;



/**
 *  订单状态数字
 */
@property (nonatomic,strong)NSNumber *orderStatusNumber;
/**
 *订单状态类型
 */
@property (nonatomic,assign)OrderStatus orderStatus;


/**
 *  支付类型数字
 */
@property (nonatomic,strong)NSNumber *payWayNumber;
/**
 *  支付类型字符串
 */
@property (nonatomic,copy)NSString *payWayStr;
/**
 *  配送类型数字
 */
@property (nonatomic,strong)NSNumber *shipWayNumber;
/**
 *  配送类型字符串
 */
@property (nonatomic,copy)NSString *shipWayStr;
/**
 *  订单状态字符串
 */
@property (nonatomic,copy)NSString *orderStatusStr;


/**
 *  订单创建时间
 */
@property (nonatomic,copy)NSString *orderCreateTime;
/**
 *  订单付款时间
 */
@property (nonatomic,copy)NSString *orderPayTime;
/**
 *  配送时间
 */
@property (nonatomic,copy)NSString *shipTime;
/**
 *  送达时间
 */
@property (nonatomic,copy)NSString *reachTime;


/**
 *  订单商品
 */
@property (nonatomic,copy)NSArray *orderGoods;
/**
 *  订单店铺名
 */
@property (nonatomic,copy)NSString *orderStoreName;
/**
 *  订单备注
 */
@property (nonatomic,copy)NSString *orderNote;
/**
 *  订单配送方式
 */
@property (nonatomic,copy)NSNumber *deliveryModeCode;
@end
