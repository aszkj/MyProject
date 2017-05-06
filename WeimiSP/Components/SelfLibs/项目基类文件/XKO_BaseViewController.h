//
//  XKO_BaseViewController.h
//  Operator_JingGang
//
//  Created by ray on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DebugSet.h"
#import "UIView+Loading.h"
#import "XKO_ViewModel.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

/**
 *  提供接口统一设置UI外形
 */
@interface XKO_BaseViewController : UIViewController

@property (nonatomic, strong) MBProgressHUD *HUD;
/**
 *  是否关闭默认的弹窗样式
 */
@property (nonatomic) BOOL closeDefaultErrorInform;
/**
 *  统一设置界面UI，如颜色,字体，圆角等
 */
- (void)setUIAppearance;
/**
 *  统一绑定UI数据及逻辑判断等
 */
- (void)bindViewModel;

/**
 *  创建frame为0的UILabel
 */
// 创建frame为CGRectZero的UILabel
- (UILabel *)createLabelWithFont:(UIFont *)font fontColor:(UIColor *)fontColor text:(NSString *)text;

// 创建frame为CGRectZero的UIImageView
- (UIImageView *)createUIImageViewWithImage:(UIImage *)image;

// 创建frame为CGRectZero的UIButton
- (UIButton *)createUIButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundColor:(UIColor *)backgroundColor hasRadius:(BOOL)hasRadius targetSelector:(SEL)selector target:(id)targetVC;

// 创建frame为CGRectZero的UIView
- (UIView *)createUIViewWithBackgroundColor:(UIColor *)backgroundColor;

// 带frame
// 创建带frame的UILabel
- (UILabel *)createLabelWithFrame:(CGRect)frame font:(UIFont *)font fontColor:(UIColor *)fontColor text:(NSString *)text;

// 创建带frame的UIImageView
- (UIImageView *)createUIImageViewWithFrame:(CGRect)frame image:(UIImage *)image;

// 创建带frame的UIButton
- (UIButton *)createUIButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundColor:(UIColor *)backgroundColor hasRadius:(BOOL)hasRadius targetSelector:(SEL)selector target:(id)targetVC;

// 创建带frame的UIView
- (UIView *)createUIViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor;

- (void)showHudTextWithErrorMessage:(NSString *)errorMessage;

@end
