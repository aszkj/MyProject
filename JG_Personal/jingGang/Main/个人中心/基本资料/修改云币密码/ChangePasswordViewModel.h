//
//  ChangePasswordViewModel.h
//  Merchants_JingGang
//
//  Created by ray on 15/9/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "XKO_ViewModel.h"

@interface ChangePasswordViewModel : XKO_ViewModel
//UI contents
@property (nonatomic) NSString *sendCodeString;
@property (nonatomic) NSString *phoneNumber;
@property (nonatomic) NSString *varificationCode;
@property (nonatomic) NSString *password;
@property (nonatomic) NSString *passwordAgain;
//commands
@property (nonatomic, readonly) RACCommand *usrInfoCommand;
@property (nonatomic, readonly) RACCommand *varifyCommand;
@property (nonatomic, readonly) RACCommand *changePasswordCommand;

@end
