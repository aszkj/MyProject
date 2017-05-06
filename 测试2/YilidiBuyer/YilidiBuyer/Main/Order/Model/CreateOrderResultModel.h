//
//  CreateOrderResultModel.h
//  YilidiBuyer
//
//  Created by yld on 16/8/5.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "OrderBaseModel.h"

@interface CreateOrderResultModel : OrderBaseModel

@property (nonatomic,strong)NSNumber *orderShipWayNumber;

@property (nonatomic,copy)NSString *orderShipWayName;

@property (nonatomic,strong)NSNumber *orderPaidAmount;

@property (nonatomic,copy)NSString *recieveCode;

@property (nonatomic,copy)NSString *deliveryCodeNote;

@property (nonatomic,copy)NSString *payTypeStr;

@end
