//
//  XKO_CreateUIViewHelper.m
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/19.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_CreateUIViewHelper.h"

@implementation XKO_CreateUIViewHelper

+ (UIView *)lineViewWith:(UIColor *)color {
    UIView *lineView = [UIView new];
    lineView.backgroundColor = color;
    lineView.frame = CGRectMake(0, 0, 0, 1.0/[UIScreen mainScreen].scale);
    return lineView;
}


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

+ (UIButton *)createUIButtonBackNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage radiusSize:(CGFloat)radiusSize frame:(CGRect)frame {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    if (normalImage) {
        [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    }
    
    if (highlightedImage) {
        [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    }
    
    if (radiusSize > 0) {
        button.layer.cornerRadius = radiusSize;
        button.layer.masksToBounds = YES;
    }
    
    return button;
}

+ (UIButton *)createUIButtonWithNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage radiusSize:(CGFloat)radiusSize frame:(CGRect)frame {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    if (normalImage) {
        [button setImage:normalImage forState:UIControlStateNormal];
    }
    
    if (highlightedImage) {
        [button setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    
    if (radiusSize > 0) {
        button.layer.cornerRadius = radiusSize;
        button.layer.masksToBounds = YES;
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

//创建不带frame的UIImageView
+ (UIImageView *)createUIImageViewWithImageName:(NSString *)imageName {
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:imageName];
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
//创建不带frame的UIButton，普通状态下带图片imgName
+ (UIButton *)createUIButtonWithImageName:(NSString *)imageName {

    UIButton *button = [UIButton new];
    if (imageName) {
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    return button;
}
//创建不带frame的UIButton，普通状态下带图片imgName，选中状态为selectedImgName
+ (UIButton *)createUIButtonWithNormalStateImageName:(NSString *)nomalImageName selectedStateImgName:(NSString *)selectedImgName
{
    UIButton *button = [UIButton new];
    if (nomalImageName) {
        [button setBackgroundImage:[UIImage imageNamed:nomalImageName] forState:UIControlStateNormal];
    }
    if (selectedImgName) {
        [button setBackgroundImage:[UIImage imageNamed:selectedImgName] forState:UIControlStateSelected];
    }
    return button;
}



// 创建带frame的UIView
+ (UIView *)createUIViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor {
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = backgroundColor;
    
    return view;    
}

// 创建带frame的UITextField
+ (UITextField *)createUITextFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder backgroundColor:(UIColor *)backgroundColor {
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = placeholder;
    if (backgroundColor) {
        textField.backgroundColor = backgroundColor;
    }
    
    return textField;
}

@end
