//
//  XKJHOnlineOrderIncomeDetailCell.h
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailsModel.h"
#import "GoodsRefundModel.h"

@interface XKJHOnlineOrderIncomeDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendQuanlabel;



@property (weak, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *consumeCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *consumeStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusValueLabel;

//作为线上收入明细
@property (nonatomic, strong)OrderDetailsModel *groupOrderModel;
//作为线上服务退款
@property (nonatomic, strong)GoodsRefundModel *goodsRefundModel;


@end
