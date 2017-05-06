//
//  UIView+Loading.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/12.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Loading)

/**
 *  显示载入动画
 */
- (void)showLoading;

- (void)showWithTitle:(NSString *)title;
/**
 *  隐藏载入动画
 */
- (void)hideLoading;

@end
