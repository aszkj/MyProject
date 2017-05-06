//
//  XKJHServicePriceCell.h
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKJHServicePriceCell : UITableViewCell

@property(nonatomic, strong) UIImageView *upImageView;
@property(nonatomic, strong) UILabel *middleName;
@property(nonatomic, strong) UILabel *voucher;
@property(nonatomic, strong) UILabel *nowMoney;
@property(nonatomic, strong) UILabel *preMoney;
@property(nonatomic, strong) UILabel *saleNum;

- (void)resetCellFrame;

@end