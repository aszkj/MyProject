//
//  DLInvoiceStatusModel.m
//  YilidiSeller
//
//  Created by yld on 16/6/11.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLInvoiceStatusModel.h"

@implementation DLInvoiceStatusModel
- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic {

    if (self) {
        
    
        self.statusCode = dic[@"statusCode"];
        self.statusCodeName = dic[@"statusCodeName"];
        self.statusTime = dic[@"statusTime"];
        self.statusNote = dic[@"statusNote"];
        
        
    }
    
    return self;
   
};

@end

@implementation DLInvoiceStatusModel (objectStatusModel)

+ (NSArray *)objectGoodsModelWithGoodsArr:(NSArray *)goodsArr{

    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:goodsArr.count];
    int a=0;
    for (NSDictionary *dic in goodsArr) {
        DLInvoiceStatusModel *model = [[DLInvoiceStatusModel alloc] initWithDefaultDataDic:dic];
        model.count=a;
        [tempArr addObject:model];
        a++;
    }
    return [tempArr copy];
    
}
@end
