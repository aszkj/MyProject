//
//  DLInvoiceStatusModel.h
//  YilidiSeller
//
//  Created by yld on 16/6/11.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface DLInvoiceStatusModel : BaseModel
@property (nonatomic,strong) NSString *statusCode;
@property (nonatomic,strong) NSString *statusCodeName;
@property (nonatomic,strong) NSString *statusTime;
@property (nonatomic,strong) NSString *statusNote;


@end

@interface DLInvoiceStatusModel (objectStatusModel)

+ (NSArray *)objectGoodsModelWithGoodsArr:(NSArray *)goodsArr;

@end