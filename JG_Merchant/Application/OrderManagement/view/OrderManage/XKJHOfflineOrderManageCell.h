//
//  XKJHOfflineOrderManageCell.h
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupOrderModel.h"

@interface XKJHOfflineOrderManageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *addTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *consumeStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendQuanlabel;
@property (nonatomic, strong)GroupOrderModel *groupOffOrderModel;
@property (weak, nonatomic) IBOutlet UIButton *refundButton;
@property (weak, nonatomic) IBOutlet UILabel *serviceLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;

@end
