//
//  DLLogisticsModel.h
//  YilidiSeller
//
//  Created by 曾勇兵 on 16/6/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLBaseModel.h"

@interface DLLogisticsModel : DLBaseModel
@property (nonatomic,strong)NSString *statisticDate;
@property (nonatomic,strong)NSString *saleOrderNo;
@property (nonatomic,strong)NSNumber *settleAmount;

@end

@interface DLLogisticsModel (logisticsModel)

+ (NSArray *)objectWithLogisticsModelArray:(NSArray *)array;

@end
