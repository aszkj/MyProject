//
//  JGActivityTools.h
//  jingGang
//
//  Created by dengxf on 15/12/9.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGActivityTools : NSObject

@property (assign, nonatomic) BOOL isPush;
@property (assign, nonatomic) BOOL isPop;
@property (assign, nonatomic) BOOL shouldShowActivity;
// 第四个模块
@property (assign, nonatomic) BOOL isServiceModule;

@property (assign, nonatomic) BOOL isShow;


// 需要显示活动页面 (在活动时间内,且用户拥有进入转场的条件)
//+ (void)needActivityView;

+ (instancetype)sharedInstance;

+ (void)mainPushToActivityView;

+ (void)activityPopToMainController;

+ (void)switchTabBarAction;
@end
