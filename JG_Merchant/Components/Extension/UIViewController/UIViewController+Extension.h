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
- (void)setLeftBar;
- (void)setLeftBarAndBackgroundColor;
- (void)addJumpButton:(SEL)action title:(NSString *)title;
- (void)btnClick;
- (void)hideHubWithOnlyText:(NSString *)hideText;

// 给导航栏添加标题
- (void)setupNavBarTitleViewWithText:(NSString *)text;
// 给导航栏添加返回键
- (void)setupNavBarPopButton;

/**
 *  隐藏底部的tabbar
 */
- (void)hiddenBottomBar;
@end
