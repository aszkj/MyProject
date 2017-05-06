//
//  DLAccountBalanceCell.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/10/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLAccountBalanceCell.h"

@implementation DLAccountBalanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DLAccountDetailsModel *)model{

    self.titleLabel.text = model.title;
    self.dateLabel.text = model.date;
    self.moneyLabel.text = model.money;
    
}
@end
