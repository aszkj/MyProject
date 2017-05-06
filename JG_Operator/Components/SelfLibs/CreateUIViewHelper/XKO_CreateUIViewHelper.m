//
//  XKO_CreateUIViewHelper.m
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/19.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_CreateUIViewHelper.h"

@implementation XKO_CreateUIViewHelper

// 创建frame为CGRectZero的UILabel
+ (UILabel *)createLabelWithFont:(UIFont *)font fontColor:(UIColor *)fontColor text:(NSString *)text{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentLeft;
    
    if (font) {
        label.font = font;
    }
    if (fontColor) {
        label.textColor = fontColor;
    }
    if (text) {
        label.text = text;
    }
    
    return label;
}

// 创建frame为CGRectZero的UIImageView
+ (UIImageView *)createUIImageViewWithImage:(UIImage *)image {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    if (image) {
        imageView.image = image;
    }
    
    return imageView;
}

// 创建frame为CGRectZero的UIButton
+ (UIButton *)createUIButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundColor:(UIColor *)backgroundColor hasRadius:(BOOL)hasRadius targetSelector:(SEL)selector target:(id)targetVC{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectZero];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (titleFont) {
        button.titleLabel.font = titleFont;
    }
    if (backgroundColor) {
        button.backgroundColor = backgroundColor;
    }
    if (hasRadius == YES) {
        button.layer.cornerRadius = kRadius;
        button.layer.masksToBounds = YES;
    }
    if (selector && targetVC) {
        [button addTarget:targetVC action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

// 创建frame为CGRectZero的UIView
+ (UIView *)createUIViewWithBackgroundColor:(UIColor *)backgroundColor {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = backgroundColor;
    
    return view;
}


// 创建带frame的UILabel
+ (UILabel *)createLabelWithFrame:(CGRect)frame font:(UIFont *)font fontColor:(UIColor *)fontColor text:(NSString *)text{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = NSTextAlignmentLeft;
    
    if (font) {
        label.font = font;
    }
    if (fontColor) {
        label.textColor = fontColor;
    }
    if (text) {
        label.text = text;
    }
    
    return label;
}

// 创建带frame的UIImageView
+ (UIImageView *)createUIImageViewWithFrame:(CGRect)frame image:(UIImage *)image {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    if (image) {
        imageView.image = image;
    }
    
    return imageView;
}

// 创建带frame的UIButton
+ (UIButton *)createUIButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundColor:(UIColor *)backgroundColor hasRadius:(BOOL)hasRadius targetSelector:(SEL)selector target:(id)targetVC{
    
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (titleFont) {
        button.titleLabel.font = titleFont;
    }
    if (backgroundColor) {
        button.backgroundColor = backgroundColor;
    }
    if (hasRadius == YES) {
        button.layer.cornerRadius = kRadius;
        button.layer.masksToBounds = YES;
    }
    if (selector && targetVC) {
        [button addTarget:targetVC action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

// 创建带frame的UIView
+ (UIView *)createUIViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor {
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = backgroundColor;
    
    return view;    
}

@end
