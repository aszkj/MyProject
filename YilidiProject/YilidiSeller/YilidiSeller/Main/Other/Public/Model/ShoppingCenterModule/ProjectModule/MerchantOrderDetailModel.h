//
//  OrderDetailModel.h
//  YilidiSeller
//
//  Created by yld on 16/5/23.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "MerchantOrderDetailBaseModel.h"
#import "ProjectRelativEmerator.h"

@interface MerchantOrderDetailModel : MerchantOrderDetailBaseModel
/**
 *  送达时间
 */
@property (nonatomic,copy)NSString *deliveryTime;

@property (nonatomic,copy)NSString *recieveCode;

@property (nonatomic,assign)SelectShipWay orderShipWay;

@property (nonatomic,strong)NSNumber *deliveryModeCode;


/**
 订单状态描述
 */
@property (nonatomic,copy)NSString *statusDesc;

/**
 *  自提客户电话
 */
@property (nonatomic,copy)NSString *buyerMobile;

@property (nonatomic,copy)NSString *deliveryModeName;
/**
 *  订单结算商品
 */
@property (nonatomic,copy)NSArray *orderSettleGoodsArr;

@property (nonatomic,strong)NSNumber *goodsSettleAmount;
/**
 *  送货时间
 */
@property (nonatomic,copy)NSString *bestTime;
/**
 *  接单时间
 */
@property (nonatomic,copy)NSString *acceptTime;
/**
 *  取消时间
 */
@property (nonatomic,copy)NSString *cancelTime;
/**
 *  完成时间
 */
@property (nonatomic,copy)NSString *finishTime;






@end
