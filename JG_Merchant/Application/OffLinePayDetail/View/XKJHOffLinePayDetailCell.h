//
//  XKJHOffLinePayDetailCell.h
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupOrderModel.h"
#import "OrderDetailsModel.h"

@interface XKJHOffLinePayDetailCell : UITableViewCell

@property (strong, nonatomic) UILabel *customerNameLabel;
@property (strong, nonatomic) UILabel *phoneNumberLabel;
@property (strong, nonatomic) UILabel *totalPriceLabel;
@property (strong, nonatomic) UILabel *addTimeLabel;
@property (strong, nonatomic) UILabel *consumeStatusLabel;
@property (strong, nonatomic) UILabel *groupService;
@property (strong, nonatomic) UIImageView *heartImg;
@property (strong, nonatomic) UIImageView *middleBgView;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

- (void)setCellData:(OrderDetailsModel *)groupOrderModel;

@end
