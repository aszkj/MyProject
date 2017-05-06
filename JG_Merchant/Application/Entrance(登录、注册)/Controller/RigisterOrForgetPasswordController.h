//
//  RigisterOrForgetPasswordController.h
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/1.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    RegisterType,       //作为注册页面
    ForgetPasswordType, //忘记密码页面
} RegisterPageType ;

@interface RigisterOrForgetPasswordController : UIViewController

@property (nonatomic, assign)RegisterPageType registerPageType;

@end
