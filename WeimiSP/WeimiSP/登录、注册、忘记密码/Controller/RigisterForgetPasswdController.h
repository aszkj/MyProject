//
//  RigisterForgetPasswdController.h
//  weimi
//
//  Created by 张康健 on 16/1/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ForgetPasswdBackBlock)(NSString *phoneNumber,NSString *passwd);
@interface RigisterForgetPasswdController : UIViewController

@property (nonatomic, strong) NSString *phoneNumberString;
@property (nonatomic, assign)BOOL isForgetPasswd;
//忘记密码返回来，传用户名和密码
@property (nonatomic, copy)ForgetPasswdBackBlock forgetPasswdBackBlock;


@end
