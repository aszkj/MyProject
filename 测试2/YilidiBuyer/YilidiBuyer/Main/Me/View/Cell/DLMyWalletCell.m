//
//  DLMyWalletCell.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/10/24.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLMyWalletCell.h"

@implementation DLMyWalletCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if (kScreenWidth ==iPhone6p_width) {
        _bgViewX.constant +=15;
        _couponBGViewX.constant +=5;
    }else if (kScreenWidth ==iPhone5_width){
        _bgViewX.constant -=15;
        _couponBGViewX.constant -=5;
        
    }
    
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(DLVouchersModel *)model{

    

    if ([model.isValidity isEqualToString:@"couponsEffective"]) {
        self.symbolLabel.textColor=UIColorFromRGB(0xff3a30);
        self.moneyLabel.textColor=UIColorFromRGB(0xff3a30);
        self.couponsLabel.textColor=UIColorFromRGB(0xff3a30);
        self.ImageBg.image = [UIImage imageNamed:@"优惠券背景"];
        
    }else if([model.isValidity isEqualToString:@"vouchersEffective"]){
        self.symbolLabel.textColor=UIColorFromRGB(0x299ef1);
        self.moneyLabel.textColor=UIColorFromRGB(0x299ef1);
        self.couponsLabel.textColor=UIColorFromRGB(0x299ef1);
        self.ImageBg.image = [UIImage imageNamed:@"抵用券"];
        
    }else if ([model.isValidity isEqualToString:@"pikEffective"]){
        self.symbolLabel.textColor=UIColorFromRGB(0x21B11E);
        self.moneyLabel.textColor=UIColorFromRGB(0x21B11E);
        self.couponsLabel.textColor=UIColorFromRGB(0x21B11E);
        self.ImageBg.image = [UIImage imageNamed:@"优惠券背景"];
        
    }else if ([model.isValidity isEqualToString:@"invalid"]){
        self.symbolLabel.textColor=UIColorFromRGB(0x8b8b8b);
        self.moneyLabel.textColor=UIColorFromRGB(0x8b8b8b);
        self.couponsLabel.textColor=UIColorFromRGB(0x8b8b8b);
            if ([model.ticketType integerValue]==1) {
                self.ImageBg.image = [UIImage imageNamed:@"优惠券背景"];
            }else if ([model.ticketType integerValue]==2){
                self.ImageBg.image = [UIImage imageNamed:@"抵用券"];
            }else{
                self.ImageBg.image = [UIImage imageNamed:@"优惠券背景"];   
        }
    }else{
        self.symbolLabel.textColor=UIColorFromRGB(0xff3a30);
        self.moneyLabel.textColor=UIColorFromRGB(0xff3a30);
        self.couponsLabel.textColor=UIColorFromRGB(0xff3a30);
        self.ImageBg.image = [UIImage imageNamed:@"优惠券背景"];
        
    }
    
    self.moneyLabel.text = [NSString stringWithFormat:@"%d",model.ticketAmount.intValue/1000];
    self.scopeLabel.text = [NSString stringWithFormat:@"%@",model.useScope];
    self.conditionsOfUseLabel.text = [NSString stringWithFormat:@"%@",model.ticketDescription];
    NSLog(@"conditionsOfUseLabel:%@",self.conditionsOfUseLabel.text);
    self.limitLabel.text = [NSString stringWithFormat:@"%@",model.limit];
    self.statusLabel.text = [NSString stringWithFormat:@"%@",model.ticketStatusName];
    self.couponsLabel.text = model.couponType;
}
@end
