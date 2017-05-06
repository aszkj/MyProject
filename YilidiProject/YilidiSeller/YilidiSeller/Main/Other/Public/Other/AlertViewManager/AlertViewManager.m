//
//  AlertViewManager.m
//  AlertViewManager
//
//  Created by leezhihua on 16/3/8.
//  Copyright © 2016年 leezhihua. All rights reserved.
//

#import "AlertViewManager.h"



@implementation AlertViewManager

- (void)showSingleAlertViewWithControllerTitle:(NSString *)controllerTitle
                                  message:(NSString *)message
                          controllerStyle:(UIAlertControllerStyle)controllerStyle
                        dismissAfterDelay:(CGFloat)afterDelay {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:controllerTitle message:message preferredStyle:controllerStyle];
    [[UIApplication sharedApplication].windows.lastObject.rootViewController presentViewController:alertC animated:YES completion:^{
        [self performSelector:@selector(dismiss:) withObject:alertC afterDelay:afterDelay];
    }];

}
- (void)dismiss:(UIAlertController *)aler {
    [aler dismissViewControllerAnimated:YES completion:nil];
}


- (void)showAlertViewWithControllerTitle:(NSString *)controllerTitle
                                 message:(NSString *)message
                         controllerStyle:(UIAlertControllerStyle)controllerStyle
                         isHaveTextField:(BOOL)isHaveTextField
                             actionTitle:(NSString *)actionTitle
                             actionStyle:(UIAlertActionStyle)actionStyle
                         alertViewAction:(AlertViewAction)alertViewAction {
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:controllerTitle message:message preferredStyle:controllerStyle];
    if (isHaveTextField == YES) {
        [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
        }];
    }
    UIAlertAction *alertOne = [UIAlertAction actionWithTitle:actionTitle style:actionStyle handler:^(UIAlertAction * _Nonnull action)  {
        alertViewAction(action);
    }];
    [alertC addAction:alertOne];
    self.alertController = alertC;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertC animated:YES completion:nil];
}

- (void)showAlertViewWithControllerTitle:(NSString *)controllerTitle
                                 message:(NSString *)message
                         controllerStyle:(UIAlertControllerStyle)controllerStyle
                         isHaveTextField:(BOOL)isHaveTextField
                             actionTitle:(NSString *)actionTitle
                             actionStyle:(UIAlertActionStyle)actionStyle
                         alertViewAction:(AlertViewAction)alertViewAction
                        otherActionTitle:(NSString *)otherActionTitle
                        otherActionStyle:(UIAlertActionStyle)otherActionStyle
                    otherAlertViewAction:(AlertViewOtherAction)otherAlertViewAction {
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:controllerTitle message:message preferredStyle:controllerStyle];
    if (isHaveTextField == YES) {
        [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
        }];
    }
    UIAlertAction *alertOne = [UIAlertAction actionWithTitle:actionTitle style:actionStyle handler:^(UIAlertAction * _Nonnull action)  {
        alertViewAction(action);
    }];
    UIAlertAction *alertTwo = [UIAlertAction actionWithTitle:otherActionTitle style:otherActionStyle handler:^(UIAlertAction * _Nonnull action)  {
        otherAlertViewAction(action);
    }];
    [alertC addAction:alertOne];
    [alertC addAction:alertTwo];
    self.alertController = alertC;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertC animated:YES completion:nil];
    
}


@end
