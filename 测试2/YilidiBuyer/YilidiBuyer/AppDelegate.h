//
//  AppDelegate.h
//  YilidiBuyer
//
//  Created by yld on 16/4/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "DLMainTabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong)DLMainTabBarController *mainController;

@property (strong, nonatomic) NSString *access_token;

@property (strong, nonatomic) NSString *openid;



@end

