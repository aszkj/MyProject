//
//  MerchantOrderBaseModel.h
//  YilidiSeller
//
//  Created by yld on 16/6/7.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "OrderBaseModel.h"
#import "TakeOrderCustomerModel.h"
#import "ProjectRelativEmerator.h"
/**
 *  商户基订单，除了基础的订单信息外，还有下单用户的信息
 */
@interface MerchantOrderBaseModel : OrderBaseModel
/**
 *  下单用户
 */
@property (nonatomic,strong)TakeOrderCustomerModel* takeOrderCustomerInfo;


@end
