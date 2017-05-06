//
//  DLOrderPaySuccessVC.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/7/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLBuyerBaseController.h"
#import "CreateOrderResultModel.h"
#import "ProjectRelativeConst.h"

@interface DLOrderPaySuccessVC : DLBuyerBaseController
@property (strong, nonatomic) IBOutlet UILabel *storeName;
@property (strong, nonatomic) IBOutlet UILabel *storeTimer;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *code;
@property (strong, nonatomic) IBOutlet UILabel *payLabel;
@property (strong, nonatomic) IBOutlet UILabel *shippingMethod;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *distributionTimer;
@property (strong, nonatomic) IBOutlet UILabel *storePhone;
@property (strong, nonatomic) IBOutlet UILabel *preferentialMoney;

@property (nonatomic,copy)NSString *orderNo;
@property (nonatomic,strong)CreateOrderResultModel *createOrderResultModel;
@property (nonatomic,copy)PopToLastPageBlock popToLastPageBlock;
@property (nonatomic,copy)BackPayRreshBlock backPayRreshBlock;
@property (nonatomic,assign)BOOL isComeFromSettleAcount;

@end
