//
//  DLRefundFailureCell.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/3/21.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLRefundFailureCell.h"
#import "DLInvoiceStatusModel.h"
@implementation DLRefundFailureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DLInvoiceStatusModel *)model {
    
    self.statusLabel.text = model.statusCodeName;
    self.contentLabel.text = model.statusNote;
    self.timerLabel.text = model.statusTime;
    
    
}

@end
