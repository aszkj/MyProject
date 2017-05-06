//
//  UIViewController+DebugJump.h
//  jingGang
//
//  Created by thinker on 15/8/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

/**
 *  隐藏底部的tabbar
 */
- (void)hiddenBottomBar;

- (void)addBackButtonIfNeed;
- (void)setLeftBar;
- (void)addJumpButton:(UIViewController *)VC title:(NSString *)title;



@end
