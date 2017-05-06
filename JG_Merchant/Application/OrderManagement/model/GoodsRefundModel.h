//
//  GoodsRefundModel.h
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/18.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsRefundModel : GoodsRefund

//根据订单状态number返回不同的订单状态str
@property (nonatomic, copy)NSString *orderStatusStr;

//时间str
@property (nonatomic, copy)NSString *dateStr;



@end
