//
//  DLAccountDetailsModel.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/10/31.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLAccountDetailsModel.h"

@implementation DLAccountDetailsModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic{

    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.title = dic[@"title"];
        self.date = dic[@"date"];
        self.money = dic[@"money"];
    }

    return self;
    
}

@end

@implementation DLAccountDetailsModel (setAccountDetailsModel)

+(NSArray *)objectAccountDetailsModelArr:(NSArray *)array {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        DLAccountDetailsModel *model = [[DLAccountDetailsModel alloc]initWithDefaultDataDic:dic];
        
        [arr addObject:model];
    }
    
    return [arr mutableCopy];

    
}

@end
