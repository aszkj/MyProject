//
//  DLVouchersModel.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/10/24.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLVouchersModel.h"
#import "NSString+Teshuzifu.h"
@implementation DLVouchersModel
- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic{

    if (self) {
        self.ticketAmount = dic[@"ticketAmount"];
        
        self.ticketDescription = dic[@"ticketDescription"];
        self.ticketStatusName = dic[@"ticketStatusName"];
        self.limit =[NSString stringWithFormat:@"有效期%@至%@",[dic[@"beginTime"]castHourMinuteSecondeStrForTheTimeStr],[dic[@"endTime"]castHourMinuteSecondeStrForTheTimeStr]];
        self.couponType = dic[@"ticketTypeName"];
        self.ticketType = dic[@"ticketType"];
        if ([self.ticketType integerValue]==1) {
            self.useScope = [NSString stringWithFormat:@"适用范围:%@",dic[@"useScope"]];
        }else{
        
            self.useScope = [NSString stringWithFormat:@"%@",dic[@"useScope"]];
        }
    }
    
    return self;
}
@end

@implementation DLVouchersModel(setVouchersModel)

+ (NSArray*)objectVouchersModelWithArr:(NSArray*)array  isValidity:(NSString*)validity{
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        DLVouchersModel *model = [[DLVouchersModel alloc]initWithDefaultDataDic:dic];
        model.isValidity = validity;
        [arr addObject:model];
    }
    
    return [arr mutableCopy];
    
}

@end
