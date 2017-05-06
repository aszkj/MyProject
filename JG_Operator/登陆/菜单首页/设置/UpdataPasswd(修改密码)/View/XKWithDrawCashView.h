//
//  XKWithDrawCashView.h
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DrawCashUpdatePasswdSureBlock)(NSString *phoneNum,NSString *veryCode,NSString *newPasswd,NSString *againPasswd);
typedef void(^DrawCashSendVeryCodeBlock)(NSString *phoneNum);

@interface XKWithDrawCashView : UIView
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendVeryCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *veryCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *newpasswdTextField;
@property (weak, nonatomic) IBOutlet UITextField *againPasswdTextField;

@property (nonatomic, copy)DrawCashUpdatePasswdSureBlock drawCashUpdatePasswdSureBlock;

@property (nonatomic, copy)DrawCashSendVeryCodeBlock drawCashSendVeryCodeBlock;

@end
