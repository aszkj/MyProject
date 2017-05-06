//
//  DLOrderListModel.m
//  YilidiBuyer
//
//  Created by yld on 16/5/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderListModel.h"


@implementation DLOrderListModel
-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.commitOrderTime = [dic[@"orderDate"] stringValue];
    }
    return self;
}


@end

@implementation DLOrderListModel (objectArr)

+ (NSArray *)objectArrWithOrderArr:(NSArray *)orderArr {

    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:orderArr.count];
    for (NSDictionary *dic in orderArr) {
        DLOrderListModel *model = [[DLOrderListModel alloc] initWithDefaultDataDic:dic];
        [tempArr addObject:model];
    }
    return [tempArr copy];
}

@end