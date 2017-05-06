//
//  DLCouponsCell.h
//  YilidiBuyer
//
//  Created by yld on 16/5/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLGetCouponModel.h"
@interface DLCouponsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *productLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;


@end

@interface DLCouponsCell (setCouponCellModel)
- (void)setCellModel:(DLGetCouponModel *)model;

@end
