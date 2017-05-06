//
//  DLMakeSureOrderGoodsCell.m
//  YilidiBuyer
//
//  Created by yld on 16/4/23.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGotoSetAcountGoodsCell.h"
#import "ProjectRelativeMaco.h"
@implementation DLGotoSetAcountGoodsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end

@implementation DLGotoSetAcountGoodsCell (setCellModel)

- (void)setCellModel:(GoodsModel *)model {
    self.goodsNameLabel.text = model.goodsName;
    self.goodsCountLabel.text = [NSString stringWithFormat:@"x%ld",model.goodsNumber.integerValue];
    self.goodsPriceLabel.attributedText = kRMBPriceStrWithPrice(model.goodsOrderPrice.floatValue, 14, 14);
    [self showGiftGoodsMarkButton:model.isAsGift];
}

- (void)setCellGiftTicketModel:(DLCouponModel *)model {
    self.goodsNameLabel.text = model.ticketTypeName;
    self.goodsCountLabel.text = [NSString stringWithFormat:@"x%ld",model.ticketCount];
    self.goodsPriceLabel.attributedText = kRMBPriceStrWithPrice(model.ticketAmount, 14, 14);
    [self showGiftGoodsMarkButton:YES];
}

- (void)showGiftGoodsMarkButton:(BOOL)showGiftGoodsMark {
    self.giftGoodsMarkButton.hidden = !showGiftGoodsMark;
    if (showGiftGoodsMark) {
        self.titleToEdgeGapConstraint.priority = Smaller_Rriority_Constraint_VALUE;
        self.tileToGiftGoosMarkButtonGapConstrait.priority = Higher_Rriority_Constraint_VALUE;
    }else {
        self.titleToEdgeGapConstraint.priority = Higher_Rriority_Constraint_VALUE;
        self.tileToGiftGoosMarkButtonGapConstrait.priority = Smaller_Rriority_Constraint_VALUE;
    }
}



@end
