//
//  DLPayResultPageModel.h
//  YilidiBuyer
//
//  Created by yld on 16/8/5.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@class StoreModel;
@interface DLPayResultPageModel : BaseModel

@property (nonatomic,copy)NSString *saleOrderNo;

@property (nonatomic,strong)NSNumber *deliveryModeCode;

@property (nonatomic,strong)NSNumber *paidAmount;

@property (nonatomic,copy)NSString *payTypeName;

@property (nonatomic,copy)NSString *deliveryModeName;

@property (nonatomic,copy)NSString *deliveryTimeNote;

@property (nonatomic,copy)NSString *receiveCode;

@property (nonatomic,strong)NSNumber*preferentialAmt;

@property (nonatomic,strong)StoreModel *storeInfo;

@end
