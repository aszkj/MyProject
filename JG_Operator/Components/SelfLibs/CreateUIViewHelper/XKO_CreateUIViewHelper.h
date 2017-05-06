//
//  XKO_CreateUIViewHelper.h
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/19.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKO_CreateUIViewHelper : NSObject

// 创建frame为CGRectZero的UILabel
+ (UILabel *)createLabelWithFont:(UIFont *)font fontColor:(UIColor *)fontColor text:(NSString *)text;

// 创建frame为CGRectZero的UIImageView
+ (UIImageView *)createUIImageViewWithImage:(UIImage *)image;

// 创建frame为CGRectZero的UIButton
+ (UIButton *)createUIButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundColor:(UIColor *)backgroundColor hasRadius:(BOOL)hasRadius targetSelector:(SEL)selector target:(id)targetVC;

// 创建frame为CGRectZero的UIView
+ (UIView *)createUIViewWithBackgroundColor:(UIColor *)backgroundColor;

// 带frame
// 创建带frame的UILabel
+ (UILabel *)createLabelWithFrame:(CGRect)frame font:(UIFont *)font fontColor:(UIColor *)fontColor text:(NSString *)text;

// 创建带frame的UIImageView
+ (UIImageView *)createUIImageViewWithFrame:(CGRect)frame image:(UIImage *)image;

// 创建带frame的UIButton
+ (UIButton *)createUIButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundColor:(UIColor *)backgroundColor hasRadius:(BOOL)hasRadius targetSelector:(SEL)selector target:(id)targetVC;

// 创建带frame的UIView
+ (UIView *)createUIViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor;

@end
