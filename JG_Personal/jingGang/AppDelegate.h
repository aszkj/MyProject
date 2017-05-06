//
//  AppDelegate.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "weatherManager.h"
#import "advertManager.h"
#import "LeftSlideViewController.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "MMDrawerVisualState.h"
#import "WXApi.h"
#import "KJOrderStatusQuery.h"
#import "DefineEnum.h"
#import <BaiduMapAPI/BMapKit.h>


#define versionOldNum @"version"
#define ISFISTRINSTALL @"ISFISTRINSTALL"

typedef void(^WXCodeReqBlock)(NSString *code);
@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate,weatherManagerDelegate,advertManagerDelegate,WXApiDelegate,BMKGeneralDelegate>
{
    weatherManager       *_weatherManager;
//    NSMutableArray       *_main_arr,*_health_arr,*_test_arr,*_goods_arr,*_comum_arr;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) NSInteger timeforCheck;
@property (nonatomic, retain) NSMutableArray  *main_arr;
@property (nonatomic, retain) NSMutableArray  *health_arr;
@property (nonatomic, retain) NSMutableArray  *test_arr;
@property (nonatomic, retain) NSMutableArray  *goods_arr;
@property (nonatomic, retain) NSMutableArray  *comum_arr;
//主页广告，生活广告，自测广告，商品页广告，社区广告数组

@property (nonatomic, copy) NSString * main_lit_img;

@property (nonatomic,strong)LeftSlideViewController *leftSlideViewController;
@property (nonatomic,strong)MMDrawerController *drawerController;
//是从个人中心跳转
@property (nonatomic,assign)BOOL isPersonCenterTtravel;

//支付跳转nav,
@property (nonatomic, strong)UINavigationController *payCommepletedTransitionNav;

//订单id
@property (nonatomic, strong)NSNumber *orderID;

@property (nonatomic, assign)JingGangPay jingGangPay;

//查询订单
@property (nonatomic, strong)KJOrderStatusQuery *orderStatusQuery;

//支付验证请求
@property (nonatomic, strong)ShopTradePaymetRequest *payResultRequest;

@property (copy , nonatomic)  WXCodeReqBlock wxCodeBlock;

@property (assign, nonatomic) BOOL getWXCode;

- (void)gogogoWithTag:(int)tag;
//判断是否第一次安装
- (BOOL)isFirstInstall;


- (void)login;
/**
 *  跳转登陆界面
 */
- (void)beGinLogin;
- (BOOL)connectedToNetwork;
@end

