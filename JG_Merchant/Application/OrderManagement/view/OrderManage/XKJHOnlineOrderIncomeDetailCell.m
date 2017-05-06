//
//  XKJHOnlineOrderIncomeDetailCell.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHOnlineOrderIncomeDetailCell.h"

@implementation XKJHOnlineOrderIncomeDetailCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)layoutSubviews {
   
   [super layoutSubviews];
    
    if (self.groupOrderModel) {//取线上服务收入model
        self.customerNameLabel.text = self.groupOrderModel.nickname;
        self.phoneNumberLabel.text = self.groupOrderModel.mobile;
        self.consumeCodeLabel.text = self.groupOrderModel.groupSn;
        self.addTimeLabel.text = self.groupOrderModel.dateStr;
//        self.totalPriceLabel.text = [self.groupOrderModel.groupPrice stringValue];
        NSLog(@"====%@",self.groupOrderModel.profitPrice);
        self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.groupOrderModel.profitPrice.floatValue];
        self.friendQuanlabel.text = [NSString stringWithFormat:@"%@",self.groupOrderModel.groupService.goodsName];
//        self.countLabel.text = [NSString stringWithFormat:@"X%@",self.groupOrderModel.groupService.goodsCount];
        self.countLabel.hidden = YES;
    }else {//取线上服务退款model
        self.customerNameLabel.text = self.goodsRefundModel.nickName;
        self.phoneNumberLabel.text = self.goodsRefundModel.mobile;
        self.consumeCodeLabel.text = self.goodsRefundModel.groupSn;
        NSString *dateStr = [self.goodsRefundModel.dateStr stringByReplacingCharactersInRange:NSMakeRange(11, 6) withString:@""];
        self.addTimeLabel.text = dateStr;
//        self.totalPriceLabel.text = [self.goodsRefundModel.groupPrice stringValue];
        self.totalPriceLabel.text = kNumberToStr(self.goodsRefundModel.groupPrice);
        self.friendQuanlabel.text = [NSString stringWithFormat:@"%@",self.goodsRefundModel.ggName];
        //隐藏个数label
        self.countLabel.hidden = YES;
        self.statusLabel.hidden = NO;
        self.statusValueLabel.hidden = NO;
        self.statusValueLabel.text = self.goodsRefundModel.orderStatusStr;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
