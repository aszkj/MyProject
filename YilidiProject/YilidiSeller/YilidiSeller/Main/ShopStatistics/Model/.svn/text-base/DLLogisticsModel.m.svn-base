//
//  DLLogisticsModel.m
//  YilidiSeller
//
//  Created by 曾勇兵 on 16/6/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLLogisticsModel.h"

@implementation DLLogisticsModel
- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    if (self) {
        self.statisticDate = dic[@"statisticDate"];
        self.saleOrderNo = dic[@"saleOrderNo"];
        self.settleAmount = dic[@"settleAmount"];
    }
    
    
    return  self;
    
}
@end

@implementation DLLogisticsModel (logisticsModel)

+ (NSArray *)objectWithLogisticsModelArray:(NSArray *)array {
    
    NSMutableArray *mutableArr = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        DLLogisticsModel *model = [[DLLogisticsModel alloc]initWithDefaultDataDic:dic];
        [mutableArr addObject:model];
    }
    
    return mutableArr;
}

@end
