//
//  JGCouponListCell.m
//  jingGang
//
//  Created by HanZhongchou on 16/1/22.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGCouponListCell.h"
#import "JGCouponDataModel.h"
#import "GlobeObject.h"
@interface JGCouponListCell()
/**
 *  横幅imageView
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBanner;
/**
 *  人民币图标
 */
@property (weak, nonatomic) IBOutlet UILabel *labelRMBIcon;
/**
 *  优惠券金额
 */
@property (weak, nonatomic) IBOutlet UILabel *labelCouponAmount;
/**
 *  优惠券有效期
 */
@property (weak, nonatomic) IBOutlet UILabel *labelCouponUsefulLife;
/**
 *  优惠券使用状态
 */
@property (weak, nonatomic) IBOutlet UILabel *labelCouponStatus;
/**
 *  优惠券名称
 */
@property (weak, nonatomic) IBOutlet UILabel *labelCouponName;
/**
 *  订单所需金额
 */
@property (weak, nonatomic) IBOutlet UILabel *labelCouponOrderAmount;

@end

#define Coupon_NoUsedColor kGetColor(74, 183, 237);
#define Coupon_UsedColor  kGetColor(173, 174, 175);

@implementation JGCouponListCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setModel:(JGCouponDataModel *)model
{
    _model = model;
    
    self.labelCouponAmount.text = _model.couponAmount;
    self.labelCouponOrderAmount.text = [NSString stringWithFormat:@"满%@元可用",_model.couponOrderAmount];
    
    _model.couponBeginTime = [_model.couponBeginTime substringToIndex:10];
    _model.couponEndTime = [_model.couponEndTime substringToIndex:10];
    self.labelCouponUsefulLife.text = [NSString stringWithFormat:@"%@~%@",_model.couponBeginTime,_model.couponEndTime];
    
    
    if (_model.couponType == 1){//商家优惠券
        self.labelCouponName.text = [NSString stringWithFormat:@"可购买%@店铺所有商品",_model.storeName];
    }
    
    
    
    if (_model.couponStatus == 0) {//在有效期内并且未使用
        self.imageViewBanner.image = [UIImage imageNamed:@"Coupon_NoUsed"];
        self.labelCouponStatus.text = @"未使用";

        
        
        self.labelRMBIcon.textColor = Coupon_NoUsedColor
        self.labelCouponAmount.textColor = Coupon_NoUsedColor
        
    }else if (_model.couponStatus == 1 ||_model.couponStatus == -1){//1已经使用  -1已经过期
        
        if (_model.couponStatus == 1) {
            self.imageViewBanner.image = [UIImage imageNamed:@"Coupon_Used"];
            self.labelCouponStatus.text = @"已使用";
        }else if (_model.couponStatus == - 1){
            self.imageViewBanner.image = [UIImage imageNamed:@"Coupon_Used"];
            self.labelCouponStatus.text = @"已过期";
        }
        
        self.labelCouponAmount.textColor = Coupon_UsedColor
        self.labelCouponName.textColor = Coupon_UsedColor
        self.labelCouponStatus.textColor = Coupon_UsedColor
        self.labelCouponUsefulLife.textColor = Coupon_UsedColor
        self.labelRMBIcon.textColor = Coupon_UsedColor
        self.labelCouponOrderAmount.textColor = Coupon_UsedColor;
    }

    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
