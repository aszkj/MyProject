//
//  OrderListModel.h
//  YilidiBuyer
//
//  Created by yld on 16/5/23.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "OrderListBaseModel.h"
#import "ProjectRelativEmerator.h"

@interface OrderListModel : OrderListBaseModel

@property (nonatomic,assign)SelectShipWay orderShipWay;

@end

@interface OrderListModel (objectArr)

+ (NSArray *)objectArrWithOrderArr:(NSArray *)orderArr;

- (void)setOrderStatus;

- (void)setOrderShipWayWithOrderShipNumber:(NSNumber *)orderShipWayNumber;




@end