//
//  DLMemberProductModel.m
//  YilidiBuyer
//
//  Created by yld on 16/6/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLMemberProductModel.h"

@implementation DLMemberProductModel
- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic{

    if (self) {
        self.imageUrl = dic[@"imageUrl"];
        self.productName = dic[@"productName"];
        self.productPrice = dic[@"productPrice"];
        self.count = dic[@"count"];
    }
    return self;
}

@end
@implementation DLMemberProductModel(setProductModel)

+ (NSArray*)objectMemberProductModelWithArr:(NSArray*)array {

    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        DLMemberProductModel *model = [[DLMemberProductModel alloc]initWithDefaultDataDic:dic];
        [arr addObject:model];
    }
    
    return [arr mutableCopy];

}

@end

