//
//  DLInvoiceListModel.m
//  YilidiSeller
//
//  Created by yld on 16/6/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLInvoiceListModel.h"

@implementation DLInvoiceListModel
- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic {

    if (self) {
        self.allotOrderNo = dic[@"allotOrderNo"];
        self.createTime = dic[@"createTime"];
        self.consignee = dic[@"consignee"];
        self.consMobile = dic[@"consMobile"];
        self.consAddress = dic[@"consAddress"];
        self.allotTotalCount = dic[@"allotTotalCount"];
        self.allotTotalAmount = dic[@"allotTotalAmount"];
        self.realAllotTotalCount = dic[@"realAllotTotalCount"];
        self.realAllotTotalAmount = dic[@"realAllotTotalAmount"];
        self.statusCodeName = dic[@"statusCodeName"];
        self.statusCode = [dic[@"statusCode"] integerValue];
        self.allotFromStoreName = dic[@"allotFromStoreName"];
    }
    return self;
    
}

@end

@implementation DLInvoiceListModel (invoiceModel)

+ (NSArray *)objectInvoiceListModelArray:(NSArray *)array {
    
    NSMutableArray *mutableArr = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        
        DLInvoiceListModel *model = [[DLInvoiceListModel alloc]initWithDefaultDataDic:dic];
        
        [mutableArr addObject:model];
        
    }
    
   
    return [mutableArr mutableCopy];
    
}

@end

