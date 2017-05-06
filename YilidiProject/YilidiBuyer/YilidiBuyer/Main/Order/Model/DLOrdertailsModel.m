//
//  DLOrdertailsModel.m
//  YilidiBuyer
//
//  Created by yld on 16/6/13.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrdertailsModel.h"

@implementation DLOrdertailsModel
- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic {

    if (self) {
        
        self.saleProductImageUrl = dic[@"saleProductImageUrl"];
            self.saleProductName = dic[@"saleProductName"];
            self.saleProductSpec = dic[@"saleProductSpec"];
                  self.brandName = dic[@"brandName"];
                    self.cartNum = dic[@"cartNum"];
                 self.orderPrice = [NSString stringWithFormat:@"%.2f",[dic[@"orderPrice"]floatValue]/1000];
        self.type = @100;
    }
    return self;
    
}


@end

@implementation DLOrdertailsModel (setOrdertailsModel)

+ (NSMutableArray *)ObjectOrdertailsModelArr:(NSArray *)valuesArr {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:valuesArr.count];
    for (NSDictionary *dic in valuesArr) {
        DLOrdertailsModel *model = [[DLOrdertailsModel alloc]initWithDefaultDataDic:dic];
        
        [array addObject:model];
    }
    
    return array;
}

@end

