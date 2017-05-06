//
//  UIAlertView+Extension.h
//  Common
//
//  Created by dengxf on 15/11/29.
//  Copyright © 2015年 dengxf. All rights reserved.
//

#import <UIKit/UIKit.h>

// 用户传入回调,处理消息框关闭事件
typedef void(^XFUIAlertViewOnDismiss)(UIAlertView *alertView,NSInteger index);

@interface UIAlertView (Extension)

/**
 *  展示一个消息框, 只有"确定"按钮，并执行回调
 *
 *  @param onDismiss 回调block,可以为nil
 */
+ (void)xf_showWithTitle:(NSString *)title
                 message:(NSString *)message
               onDismiss:(void(^)())onDismiss;

/**
 *  展示一个无按钮消息框，自动延时关闭，并执行回调
 *
 *  @param delayInSeconds 妙计的延时，0或负时表示默认延时2s
 *  @param onDismiss      回调block，可以为nil
 */
+ (void)xf_showWithTitle:(NSString *)title
                 message:(NSString *)message
                   delay:(float)delayInSeconds
               onDismiss:(void(^)())onDismiss;

/**
 *  展示一个消息框，关闭时执行回调
 *
 *  @param ...: 变长参数，0~N个字符串加一个结束符(nil或block) block类型为UIAlertViewOnDismiss
 */
+ (void)xf_shoeWithTitle:(NSString *)title message:(NSString *)message buttonsAndOnDismiss:(NSString *)cancelButtonTitle, ...;


@end
