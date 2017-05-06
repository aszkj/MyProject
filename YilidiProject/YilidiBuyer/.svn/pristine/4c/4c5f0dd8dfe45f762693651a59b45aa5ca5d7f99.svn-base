//
//  DLOrderDetaiCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderDetaiCell.h"
#import "UIImageView+sd_SetImg.h"
#import "DLOrdertailsModel.h"
@implementation DLOrderDetaiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DLOrdertailsModel *)model {

    [self.productImage sd_SetImgWithUrlStr:[NSString stringWithFormat:@"%@",model.saleProductImageUrl] placeHolderImgName:nil];
    self.productName.text = model.saleProductName;
    self.productSpecification.text = model.saleProductSpec;
    self.productCount.text = [NSString stringWithFormat:@"x%@",model.cartNum];
    self.productPrice.text = [NSString stringWithFormat:@"￥%@",model.orderPrice];
    
}
@end
