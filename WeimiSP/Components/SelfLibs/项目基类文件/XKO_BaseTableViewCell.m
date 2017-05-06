//
//  XKO_BaseTableViewCell.m
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/19.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_BaseTableViewCell.h"
#import "XKO_CreateUIViewHelper.h"

@implementation XKO_BaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 创建UI

// 创建frame为CGRectZero的UILabel
- (UILabel *)createLabelWithFont:(UIFont *)font fontColor:(UIColor *)fontColor text:(NSString *)text{
    
    return [XKO_CreateUIViewHelper createLabelWithFont:font fontColor:fontColor text:text];
}

// 创建frame为CGRectZero的UIImageView
- (UIImageView *)createUIImageViewWithImage:(UIImage *)image {
    
    return [XKO_CreateUIViewHelper createUIImageViewWithImage:image];
}

// 创建frame为CGRectZero的UIButton
- (UIButton *)createUIButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundColor:(UIColor *)backgroundColor hasRadius:(BOOL)hasRadius targetSelector:(SEL)selector target:(id)targetVC{
    
    return [XKO_CreateUIViewHelper createUIButtonWithTitle:title titleColor:titleColor titleFont:titleFont backgroundColor:backgroundColor hasRadius:hasRadius targetSelector:selector target:targetVC];
}

// 创建frame为CGRectZero的UIView
- (UIView *)createUIViewWithBackgroundColor:(UIColor *)backgroundColor {
    
    return [XKO_CreateUIViewHelper createUIViewWithBackgroundColor:backgroundColor];
}

// 带frame
// 创建带frame的UILabel
- (UILabel *)createLabelWithFrame:(CGRect)frame font:(UIFont *)font fontColor:(UIColor *)fontColor text:(NSString *)text {
    
    return [XKO_CreateUIViewHelper createLabelWithFrame:frame font:font fontColor:fontColor text:text];
}

// 创建带frame的UIImageView
- (UIImageView *)createUIImageViewWithFrame:(CGRect)frame image:(UIImage *)image {
    
    return [XKO_CreateUIViewHelper createUIImageViewWithFrame:frame image:image];
}

// 创建带frame的UIButton
- (UIButton *)createUIButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundColor:(UIColor *)backgroundColor hasRadius:(BOOL)hasRadius targetSelector:(SEL)selector target:(id)targetVC {
    
    return [XKO_CreateUIViewHelper createUIButtonWithFrame:frame title:title titleColor:titleColor titleFont:titleFont backgroundColor:backgroundColor hasRadius:hasRadius targetSelector:selector target:targetVC];
}

// 创建带frame的UIView
- (UIView *)createUIViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor {
    
    return [XKO_CreateUIViewHelper createUIViewWithFrame:frame backgroundColor:backgroundColor];
}


@end
