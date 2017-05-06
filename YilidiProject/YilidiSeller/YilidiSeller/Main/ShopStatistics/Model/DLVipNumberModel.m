//
//  DLVipNumberModel.m
//  YilidiSeller
//
//  Created by yld on 16/6/1.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLVipNumberModel.h"

@implementation DLVipNumberModel
- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic {

    if (self) {
        self.date = dic[@"statisticDate"];
        self.vipNumber = dic[@"vipUserCount"];
        self.registerNumber = dic[@"registCount"];
    }
    
    
    return  self;
    
}
@end


@implementation DLVipNumberModel (vipNumberModel)

+ (NSArray *)objectWithVipNumberModelArray:(NSArray *)array {

    NSMutableArray *mutableArr = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        DLVipNumberModel *model = [[DLVipNumberModel alloc]initWithDefaultDataDic:dic];
        [mutableArr addObject:model];
    }
    
    return mutableArr;
}

@end


