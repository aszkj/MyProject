//
//  GroupOrderModel.h
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/12.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "GroupOrder.h"

@interface GroupOrderModel : GroupOrder

//线上订单状态 str
@property (nonatomic, copy)NSString *orderStatusStr;

//线下订单状态
@property (nonatomic, copy)NSString *offLineOrderStatusStr;

//时间str
@property (nonatomic, copy)NSString *dateStr;

//是否退款
@property (nonatomic, assign)BOOL hasReturnedMoney;

//是否显示非会员,还是名称
@property (nonatomic, copy)NSString *displayName;




@end
