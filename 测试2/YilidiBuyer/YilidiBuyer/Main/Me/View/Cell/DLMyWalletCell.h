//
//  DLMyWalletCell.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/10/24.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLVouchersModel.h"

@interface DLMyWalletCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *symbolLabel;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *couponsLabel;
@property (strong, nonatomic) IBOutlet UILabel *scopeLabel;
@property (strong, nonatomic) IBOutlet UILabel *conditionsOfUseLabel;
@property (strong, nonatomic) IBOutlet UILabel *limitLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (nonatomic,strong)DLVouchersModel *model;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bgViewX;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *couponBGViewX;
@property (strong, nonatomic) IBOutlet UIImageView *ImageBg;

@end
