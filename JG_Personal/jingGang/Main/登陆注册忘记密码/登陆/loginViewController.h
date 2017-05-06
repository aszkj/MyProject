//
//  loginViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//


//用户注册和登录功能
#import <UIKit/UIKit.h>
#import "loginAndRegistManager.h"
#import "VApiManager.h"
#import "AccessToken.h"

@interface loginViewController : UIViewController<LoginAndRegistManagerDelegate>
{
    loginAndRegistManager           *_loginManager;
}

@end
