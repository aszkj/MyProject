//
//  UpdatePasswdView.h
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UpdatePasswdSureBlock)(NSString *oldPasswd,NSString *newPasswd,NSString *againPasswd);

@interface UpdatePasswdView : UIView
@property (weak, nonatomic) IBOutlet UITextField *oldPasswdTextField;
@property (weak, nonatomic) IBOutlet UITextField *newpasswdTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *againNewPasswdTextField;

@property (nonatomic, copy)UpdatePasswdSureBlock updatePasswdSureBlock;

@end
