//
//  DLOrderDetailVC.h
//  YilidiSeller
//
//  Created by yld on 16/6/7.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLSellerBaseController.h"
#import "MerchantOrderDetailModel.h"

@interface DLOrderDetailVC : DLSellerBaseController

@property (nonatomic,copy)NSString *orderNo;

@property (nonatomic,copy)NSString *recieveCode;

@property (nonatomic,strong)MerchantOrderDetailModel *orderDetailModel;

@end
