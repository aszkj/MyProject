//
//  MBProgressHUD+Show.h
//  weibo
//
//  Created by 张鹏 on 13-9-1.
//  Copyright (c) Elvis All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Show)

+ (void)showErrorWithText:(NSString *)text;
+ (void)showSuccessWithText:(NSString *)text;
+ (void)showDarkErrorWithText:(NSString *)text andDelayTime:(NSTimeInterval)delay;
+ (void)showDarkErrorWithText:(NSString *)text;
+ (void)showDarkSuccessWithText:(NSString *)text;
+ (void)showDarkSuccessWithText:(NSString *)text inView:(UIView *)view;


// 苏有良 2015-3-27
// 添加标题，详细内容提示框
+ (void)showMessageWithText:(NSString *)text detailText:(NSString *)detailText;

@end
