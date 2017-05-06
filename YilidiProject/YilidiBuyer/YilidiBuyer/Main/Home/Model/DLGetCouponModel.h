//
//  DLGetCouponModel.h
//  YilidiBuyer
//
//  Created by yld on 16/5/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface DLGetCouponModel : BaseModel
@property (nonatomic,assign)int couponId;
@property (nonatomic,strong)NSString *couponName;
@property (nonatomic,assign)NSNumber *couponValue;
@property (nonatomic,strong)NSString *expirationDate;
@property (nonatomic,strong)NSString *descr;
@property (nonatomic,assign)BOOL isReceive;
@end
