//
//  UIAlertView+Extension.m
//  Common
//
//  Created by dengxf on 15/11/29.
//  Copyright © 2015年 dengxf. All rights reserved.
//

#import "UIAlertView+Extension.h"

/*
 * 仅供内部使用，取代UIAlertView并作为自身的Delegate
 */
@interface  UIAlertViewBase: UIAlertView <UIAlertViewDelegate>
@property (nonatomic, copy) XFUIAlertViewOnDismiss onDismiss;
@end

@implementation UIAlertViewBase

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.onDismiss) {
        self.onDismiss(alertView, buttonIndex);
    }
}

@end

@implementation UIAlertView (Extension)

+ (void)xf_showWithTitle:(NSString *)title message:(NSString *)message onDismiss:(void (^)())onDismiss
{
    [UIAlertView xf_shoeWithTitle:title message:message buttonsAndOnDismiss:@"确定",^(UIAlertView *alert,NSInteger index){
        if (onDismiss) {
            onDismiss();
        }
    }];
}

+ (void)xf_showWithTitle:(NSString *)title
                 message:(NSString *)message
                   delay:(float)delayInSeconds
               onDismiss:(void (^)())onDismiss
{
    if (delayInSeconds <= 0.0) {
        delayInSeconds = 2.0;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil];
    [alert show];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        if (onDismiss) {
            onDismiss();
        }
    });
}


+ (void)xf_shoeWithTitle:(NSString *)title message:(NSString *)message buttonsAndOnDismiss:(NSString *)cancelButtonTitle, ...
{
    va_list args;
    id arg = nil;
    XFUIAlertViewOnDismiss onDismiss = nil;
    
    UIAlertViewBase *alert = [[UIAlertViewBase alloc] initWithTitle:title
                                                                        message:message
                                                                       delegate:nil
                                                              cancelButtonTitle:cancelButtonTitle
                                                              otherButtonTitles:nil];
    
    // 扫描参数列表
    va_start(args, cancelButtonTitle);
    while ((arg = va_arg(args, id))) {
        if ([arg isKindOfClass:[NSString class]]) {
            [alert addButtonWithTitle:arg];
        }
        else {
            // block 结尾
            onDismiss = arg;
            break;
        }
    }
    va_end(args);
    
    // 设置回调
    if (onDismiss) {
        // copy
        alert.onDismiss = onDismiss;
        // 弱引用
        alert.delegate = alert;
    }
    
    [alert show];

}

@end
