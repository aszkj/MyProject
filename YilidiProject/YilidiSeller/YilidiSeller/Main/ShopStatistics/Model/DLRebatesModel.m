//
//  DLRebatesModel.m
//  YilidiSeller
//
//  Created by yld on 16/6/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLRebatesModel.h"

@implementation DLRebatesModel
- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    if (self) {
        self.statisticDate = dic[@"statisticDate"];
        self.saleOrderNo = dic[@"saleOrderNo"];
        self.settleAmount = dic[@"settleAmount"];
    }
    
    
    return  self;
    
}
@end

@implementation DLRebatesModel (rebatesModel)

+ (NSArray *)objectWithrebatesModelArray:(NSArray *)array {
    
    NSMutableArray *mutableArr = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        DLRebatesModel *model = [[DLRebatesModel alloc]initWithDefaultDataDic:dic];
        [mutableArr addObject:model];
    }
    
    return mutableArr;
}

@end
