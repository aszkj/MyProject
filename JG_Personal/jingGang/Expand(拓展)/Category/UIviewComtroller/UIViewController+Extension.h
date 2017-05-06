//
//  UIViewController+DebugJump.h
//  jingGang
//
//  Created by thinker on 15/8/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

+ (UIViewController *)appRootViewController;


- (void)addBackButtonIfNeed;

- (void)setLeftBarAndBackgroundColor;
- (void)addJumpButton:(SEL)action title:(NSString *)title;
- (void)btnClick;

- (void)hideHubWithOnlyText:(NSString *)hideText;

// 给导航栏添加标题
- (void)setupNavBarTitleViewWithText:(NSString *)text;

// 给导航栏添加返回键
- (void)setupNavBarPopButton;
//导航栏右侧按钮
- (void)setupNavBarRightButtonWithTitle:(NSString *)title;

// 隐藏导航栏返回键
- (void)hiddenNavBarPopButton;

// 添加一个常用的lab
- (UILabel *)createLabWithFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment;

/**
 *  验证电话合法性
 */
- (BOOL)validateNumberWithPhoneNumber:(NSString *)phoneNumber;

/**
 *  显示遮罩层 */
- (void)showHud;

/**
 *  隐藏遮罩层 */
- (void)hiddenHud;

- (void)saveWithUserDefaultsWithObject:(id)object key:(NSString *)key;

- (id)getUserDefaultWithKey:(NSString *)key;

@end
