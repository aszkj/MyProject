//
//  DLMakeSureOrderGoodsCell.m
//  YilidiBuyer
//
//  Created by yld on 16/4/23.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderRefundDetailGoodsCell.h"
#import "ProjectRelativeMaco.h"
@implementation DLOrderRefundDetailGoodsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end

@implementation DLOrderRefundDetailGoodsCell (setCellModel)

- (void)setCellModel:(GoodsModel *)model {

    self.goodsNameLabel.text = model.goodsName;
    self.goodsCountLabel.text = [NSString stringWithFormat:@"x%ld",model.goodsNumber.integerValue];
    self.goodsPriceLabel.attributedText = kRMBPriceStrWithPrice(model.goodsSettlePrice.floatValue, 13, 13);
}

@end