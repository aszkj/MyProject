//
//  DLBrandModel.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/12/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLBrandModel.h"

@implementation DLBrandModel
- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic{

    self =[super initWithDefaultDataDic:dic];
    if (self) {
        
        self.brandUrl = dic[@"brandLogoImageUrl"];
        self.brandName = dic[@"brandName"];
        self.brandCode = dic[@"brandCode"];
    }
    
    return self;
}
@end

@implementation DLBrandModel (setBrandModel)

+ (NSArray*)objectBrandModelWithArr:(NSArray*)array{

    NSMutableArray *mutubaleArr = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        
        DLBrandModel *model = [[DLBrandModel alloc]initWithDefaultDataDic:dic];
        [mutubaleArr addObject:model];
        
    }
    
    
    return [mutubaleArr mutableCopy];
    
}

@end
