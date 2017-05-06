//
//  DLInvoiceListModel.h
//  YilidiSeller
//
//  Created by yld on 16/6/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface DLInvoiceListModel : BaseModel

@property (nonatomic,strong)NSString *allotOrderNo;
@property (nonatomic,strong)NSString *createTime;
@property (nonatomic,strong)NSString *consignee;
@property (nonatomic,strong)NSString *consMobile;
@property (nonatomic,strong)NSString *consAddress;
@property (nonatomic,strong)NSNumber *allotTotalCount;
@property (nonatomic,strong)NSNumber *allotTotalAmount;
@property (nonatomic,strong)NSNumber *realAllotTotalCount;
@property (nonatomic,strong)NSNumber *realAllotTotalAmount;
@property (nonatomic,strong)NSString *statusCodeName;
@property (nonatomic,strong)NSString *allotFromStoreName;
@property (nonatomic,assign)NSInteger statusCode;


@end

@interface DLInvoiceListModel (invoiceModel)

+ (NSArray *)objectInvoiceListModelArray:(NSArray *)array;

@end