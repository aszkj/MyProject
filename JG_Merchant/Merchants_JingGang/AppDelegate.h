//
//  AppDelegate.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/1.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKJHRootController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (copy, nonatomic) NSMutableArray *userFilePathArray;   //用户信息的plist的路径集合
@property (nonatomic) BOOL hasLogin;                      //是否登陆

@end

