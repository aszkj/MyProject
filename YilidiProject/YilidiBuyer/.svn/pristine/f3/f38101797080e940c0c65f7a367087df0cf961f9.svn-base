//
//  DLOrderCouponsCell.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/5/4.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLOrderCouponsCell.h"
#import "DLVouchersModel.h"
@implementation DLOrderCouponsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if (kScreenWidth ==iPhone6p_width) {
        _contentBgViewX.constant +=15;
        _quanBgViewX.constant +=5;
    }else if (kScreenWidth ==iPhone5_width){
        _contentBgViewX.constant -=15;
        _quanBgViewX.constant -=5;
        
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DLVouchersModel *)model{

    self.moneyLabel.text = [NSString stringWithFormat:@"%d",model.ticketAmount.intValue/1000];
    self.ticketTypeName.text = model.couponType;
    self.titleLabel.text = model.useScope;
    self.contentLabel.text = model.ticketDescription;
    self.timerLabel.text = model.limit;
    
    
    
}
@end
