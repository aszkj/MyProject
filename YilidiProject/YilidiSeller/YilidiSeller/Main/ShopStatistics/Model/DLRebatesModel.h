//
//  DLRebatesModel.h
//  YilidiSeller
//
//  Created by yld on 16/6/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface DLRebatesModel : BaseModel
@property (nonatomic,strong)NSString *statisticDate;
@property (nonatomic,strong)NSString *saleOrderNo;
@property (nonatomic,strong)NSNumber *settleAmount;
@end

@interface DLRebatesModel (rebatesModel)

+ (NSArray *)objectWithrebatesModelArray:(NSArray *)array;

@end