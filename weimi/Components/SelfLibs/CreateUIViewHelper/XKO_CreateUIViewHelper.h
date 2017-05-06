//
//  XKO_CreateUIViewHelper.h
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/19.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKO_CreateUIViewHelper : NSObject

/**
 *  创建一个像素高度的视图
 *
 *  @param color 指定视图颜色
 *
 *  @return 一个像素高度的视图
 */
+ (UIView *)lineViewWith:(UIColor *)color;

// 创建frame为CGRectZero的UILabel
+ (UILabel *)createLabelWithFont:(UIFont *)font fontColor:(UIColor *)fontColor text:(NSString *)text;

// 创建frame为CGRectZero的UIImageView
+ (UIImageView *)createUIImageViewWithImage:(UIImage *)image;

// 创建frame为CGRectZero的UIButton
+ (UIButton *)createUIButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundColor:(UIColor *)backgroundColor hasRadius:(BOOL)hasRadius targetSelector:(SEL)selector target:(id)targetVC;

// 创建图片UIButton
+ (UIButton *)createUIButtonWithNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage radiusSize:(CGFloat)radiusSize frame:(CGRect)frame;
+ (UIButton *)createUIButtonBackNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage radiusSize:(CGFloat)radiusSize frame:(CGRect)frame;


// 创建frame为CGRectZero的UIView
+ (UIView *)createUIViewWithBackgroundColor:(UIColor *)backgroundColor;

// 带frame
// 创建带frame的UILabel
+ (UILabel *)createLabelWithFrame:(CGRect)frame font:(UIFont *)font fontColor:(UIColor *)fontColor text:(NSString *)text;

// 创建带frame的UIImageView
+ (UIImageView *)createUIImageViewWithFrame:(CGRect)frame image:(UIImage *)image;

//创建不带frame的UIImageView
+ (UIImageView *)createUIImageViewWithImageName:(NSString *)imageName;

// 创建带frame的UIButton
+ (UIButton *)createUIButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundColor:(UIColor *)backgroundColor hasRadius:(BOOL)hasRadius targetSelector:(SEL)selector target:(id)targetVC;

//创建不带frame的UIButton，普通状态下带图片imgName
+ (UIButton *)createUIButtonWithImageName:(NSString *)imageName;

//创建不带frame的UIButton，普通状态下带图片imgName，选中状态为selectedImgName
+ (UIButton *)createUIButtonWithNormalStateImageName:(NSString *)nomalImageName selectedStateImgName:(NSString *)selectedImgName;


// 创建带frame的UIView
+ (UIView *)createUIViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor;

// 创建带frame的UITextField
+ (UITextField *)createUITextFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder backgroundColor:(UIColor *)backgroundColor;

@end
