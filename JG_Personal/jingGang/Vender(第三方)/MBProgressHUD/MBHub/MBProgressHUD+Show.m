//
//  MBProgressHUD+Show.m
//  weibo
//
//  Created by 张鹏 on 13-9-1.
//  Copyright (c) Elvis All rights reserved.
//

#import "MBProgressHUD+Show.h"

@implementation MBProgressHUD (Show)
+ (void)showText:(NSString *)text name:(NSString *)name andIsDark:(BOOL)isDark andDelayTime:(NSTimeInterval)delay
{
    // 显示加载失败
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    // 显示一张图片(mode必须写在customView设置之前)
    hud.mode = MBProgressHUDModeCustomView;
    if(name){
    // 设置一张图片
    name = [NSString stringWithFormat:@"MBProgressHUD.bundle/%@", name];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    }
    hud.labelText = text;
    
    // 隐藏的时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
#pragma mark - 标记
//    hud.darkBlur=isDark;
    
    // 1秒后自动隐藏
    [hud hide:YES afterDelay:delay];
}

+ (void)showText:(NSString *)text
            name:(NSString *)name
       andIsDark:(BOOL)isDark
    andDelayTime:(NSTimeInterval)delay
          inView:(UIView *)view
{
    // 显示加载失败
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // 显示一张图片(mode必须写在customView设置之前)
    hud.mode = MBProgressHUDModeCustomView;
    if(name){
        // 设置一张图片
        name = [NSString stringWithFormat:@"MBProgressHUD.bundle/%@", name];
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    }
    hud.labelText = text;
    
    // 隐藏的时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
//    hud.darkBlur=isDark;
    
    // 1秒后自动隐藏
    [hud hide:YES afterDelay:delay];
}

//普通效果
+ (void)showErrorWithText:(NSString *)text andDelayTime:(NSTimeInterval)delay
{
    [self showText:text name:@"error.png" andIsDark:NO andDelayTime:delay];
}
+ (void)showErrorWithText:(NSString *)text
{
    [self showText:text name:@"error.png" andIsDark:NO andDelayTime:2];
}

+ (void)showSuccessWithText:(NSString *)text
{
    [self showText:text name:@"success.png" andIsDark:NO andDelayTime:2];
}

//黑色效果
+ (void)showDarkErrorWithText:(NSString *)text andDelayTime:(NSTimeInterval)delay
{
    [self showText:text name:@"error.png" andIsDark:YES andDelayTime:delay];
}

+ (void)showDarkErrorWithText:(NSString *)text
{
    [self showText:text name:nil andIsDark:YES andDelayTime:1.5f];
}

+ (void)showDarkSuccessWithText:(NSString *)text
{
    [self showText:text name:@"success.png" andIsDark:YES andDelayTime:2];
}

+ (void)showDarkSuccessWithText:(NSString *)text inView:(UIView *)view
{
    [self showText:text name:@"success.png" andIsDark:YES andDelayTime:2.0 inView:view];
}

// 苏有良 2015-3-27
// 添加标题，详细内容提示框
+ (void)showMessageWithText:(NSString *)text detailText:(NSString *)detailText
{
    // 显示加载
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    // 显示一张图片(mode必须写在customView设置之前)
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.labelText = text;
    hud.detailsLabelText = detailText;
    
    // 隐藏的时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
//    hud.darkBlur=NO;
    
    // 1秒后自动隐藏
    [hud hide:YES afterDelay:2.0];
}

@end
