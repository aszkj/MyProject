//
//  DLCouponsCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLCouponsCell.h"

@implementation DLCouponsCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation DLCouponsCell (setCouponCellModel)
- (void)setCellModel:(DLGetCouponModel *)model {

    self.priceLabel.text = [NSString stringWithFormat:@"%@",model.couponValue];
    self.productLabel.text = model.couponName;
    self.dateLabel.text = model.expirationDate;
    self.desLabel.text = model.descr;
    
}
@end
