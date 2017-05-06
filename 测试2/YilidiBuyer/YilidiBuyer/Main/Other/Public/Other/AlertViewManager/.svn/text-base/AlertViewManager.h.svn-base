//
//  AlertViewManager.h
//  AlertViewManager
//
//  Created by leezhihua on 16/3/8.
//  Copyright © 2016年 leezhihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^AlertViewAction)(UIAlertAction *action);
typedef void(^AlertViewOtherAction)(UIAlertAction *action);

@interface AlertViewManager : NSObject

@property (nonatomic, strong) UIAlertController *alertController;

//只有提示框
- (void)showSingleAlertViewWithControllerTitle:(NSString *)controllerTitle
                                     message:(NSString *)message
                             controllerStyle:(UIAlertControllerStyle)controllerStyle
                           dismissAfterDelay:(CGFloat)afterDelay;



//只有一个action
- (void)showAlertViewWithControllerTitle:(NSString *)controllerTitle
                                 message:(NSString *)message
                         controllerStyle:(UIAlertControllerStyle)controllerStyle
                         isHaveTextField:(BOOL)isHaveTextField
                             actionTitle:(NSString *)actionTitle
                             actionStyle:(UIAlertActionStyle)actionStyle
                         alertViewAction:(AlertViewAction)alertViewAction;

//两个action
- (void)showAlertViewWithControllerTitle:(NSString *)controllerTitle
                                 message:(NSString *)message
                         controllerStyle:(UIAlertControllerStyle)controllerStyle
                         isHaveTextField:(BOOL)isHaveTextField
                             actionTitle:(NSString *)actionTitle
                             actionStyle:(UIAlertActionStyle)actionStyle
                         alertViewAction:(AlertViewAction)alertViewAction
                        otherActionTitle:(NSString *)otherActionTitle
                        otherActionStyle:(UIAlertActionStyle)otherActionStyle
                    otherAlertViewAction:(AlertViewOtherAction)otherAlertViewAction;
@end
