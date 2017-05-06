//
//  DLRefundDetailsCell.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/3/20.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLRefundDetailsCell.h"
#import "DLInvoiceStatusModel.h"
@implementation DLRefundDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DLInvoiceStatusModel *)model {
    
    self.orderStatus.text = model.statusCodeName;
    self.orderTime.text = model.statusTime;
    
    
}

@end
