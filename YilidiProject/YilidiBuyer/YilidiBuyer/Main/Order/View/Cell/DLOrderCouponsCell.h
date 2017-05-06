//
//  DLOrderCouponsCell.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/5/4.
//  Copyright © 2017年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DLVouchersModel;
@interface DLOrderCouponsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *quanBgViewX;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentBgViewX;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *ticketTypeName;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (nonatomic,strong)  DLVouchersModel *model;
@end
