//
//  AppDelegate.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/1.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "AppDelegate.h"

#import <ShareSDK/ShareSDK.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import <QZoneConnection/ISSQZoneApp.h>
#import <QZoneConnection/QZoneConnection.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

#import "DebugSet.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件
#import <BaiduMapAPI/BMKMapView.h>//只引入所需的单个头文件
#import "XKO_BaseNavigationController.h"
#import "MainViewController.h"
#import "WalletViewController.h"
#import "KJLoginController.h"
#import "JPUSHService.h"

#define k_BaiduMapKey @"j0Ft0VZca1GGvNlWGgdaildY"

@interface AppDelegate ()<BMKGeneralDelegate>
{
    BMKMapManager* _mapManager;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [UIViewController new];
    [DebugSet setLogger];

    [self setBaiduMapKey];
    
    //激活键盘管理
    [self activeKeyBoardManager];
    
//    if (self.userFilePathArray && self.userFilePathArray.count > 0) {
//        self.hasLogin = YES;
////        [self enterRootView];
//        [self enterLoginView];
//    }
//    else {
//        self.hasLogin = NO;
//        [self enterLoginView];
////        [self enterRootView];
//    }

    //shareSDK分享配置
    [self _initThirdPlatformInfo];
    
    // 开始动画
    [self startAnimation];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    //初始化激光推送SDK
    [self iniJpushSDkWithOptions:launchOptions];
    
    
    
    return YES;
}


/**
 *  初始化激光推送SDK
 */
- (void)iniJpushSDkWithOptions:(NSDictionary *)launchOptions
{
    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    JGLog(@"%@",launchOptions);
    // Required
    //如需兼容旧版本的方式，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化和同时使用pushConfig.plist文件声明appKey等配置内容。
//    [JPUSHService setupWithOption:launchOptions appKey:@"b88aed4f04d46546a43ba34d" channel:@"Publish channel" apsForProduction:@"0"];

//    [JPUSHService setupWithOption:launchOptions];
}


- (void)startAnimation {
    
    //圖片擴大淡出的效果开始;
    //设置背景图片;
    UIImageView *niceView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight)];
    niceView.image = [UIImage imageNamed:@"init_back_ground"];
    
    //设置logo;
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 81, -77, 162, 77)];
    logoView.image = [UIImage imageNamed:@"init_logo"];
    [niceView addSubview:logoView];
    
    //设置运营商图片;
    UIImageView *operatorView = [[UIImageView alloc] initWithFrame:CGRectZero];
    operatorView.image = [UIImage imageNamed:@"bk_yes_operator"];
    operatorView.alpha = 0;
    [niceView addSubview:operatorView];
    
    [operatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(niceView.mas_centerX);
        make.bottom.equalTo(niceView.mas_bottom).with.offset(-50);
        make.size.mas_equalTo(CGSizeMake(63, 25));
    }];
    
    //设置文字;
    UIImageView *textView = [[UIImageView alloc] initWithFrame:CGRectZero];
    textView.image = [UIImage imageNamed:@"init_text"];
    textView.alpha = 0;
    [niceView addSubview:textView];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(niceView.mas_centerX);
        make.centerY.equalTo(niceView.mas_centerY).with.offset(-50);
        make.size.mas_equalTo(CGSizeMake(162, 20));
    }];
    
    //添加到场景
    [self.window addSubview:niceView];
    
    //放到最顶层;
    [self.window bringSubviewToFront:niceView];
    
    //开始设置动画;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.window cache:YES];
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDidStopSelector:@selector(startupAnimationDone)];
    
    operatorView.alpha = 1;
    textView.alpha = 1;
    
    logoView.frame =CGRectMake(kScreenWidth/2 - 81, kScreenHeight/2 - 140, 162, 77);
    
    [UIView commitAnimations];
}

- (void)startupAnimationDone {
    
    int64_t delayInSeconds = 1.5;
    /*
     *@parameter 1,时间参照，从此刻开始计时
     *@parameter 2,延时多久，此处为秒级，还有纳秒等。10ull * NSEC_PER_MSEC
     */
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSString *token = GetToken;
        if (token) {//之前已经登录过
            //查询商户审核进度
            [self enterRootView];
        }else {//登录
            [self enterLoginView];
        }
    });
}

#pragma mark - 进入主界面
- (void)enterRootView
{
    MainViewController *root = [[MainViewController alloc] init];
    XKO_BaseNavigationController *nav = [[XKO_BaseNavigationController alloc] initWithRootViewController:root];
    self.window.rootViewController = nav;
}

#pragma mark - 进入登录页面
- (void)enterLoginView
{
    KJLoginController *login = [[KJLoginController alloc] init];
    XKO_BaseNavigationController *nav = [[XKO_BaseNavigationController alloc] initWithRootViewController:login];
    self.window.rootViewController = nav;
}

#pragma mark - 键盘管理 激活
-(void)activeKeyBoardManager{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}

#pragma mark - 百度地图key配置
- (void)setBaiduMapKey
{
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:k_BaiduMapKey  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}
- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - debug operation
- (void)updateOnClassInjection {
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    WalletViewController *VC = [[WalletViewController alloc] initWithNibName:@"WalletViewController" bundle:nil];
    [nav pushViewController:VC animated:YES];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}




#pragma mark - 第三方平台信息初始化
-(void)_initThirdPlatformInfo{
    
    //ShareSDK 模块
    [ShareSDK registerApp:Mob_share_key];
    
    //微信模块
    [ShareSDK connectWeChatWithAppId:Weixin_AppID appSecret:Weixin_AppSecret wechatCls:[WXApi class]];
//    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885" wechatCls:[WXApi class]];
    //微信支付appid
    //    [WXApi registerApp:@"wx1370b545c166cc0d"];
//    [WXApi registerApp:@"wx5789cef4a9508420"];
    
     
    //    //新浪微博//
    [ShareSDK connectSinaWeiboWithAppKey:Weibo_Appkey
                               appSecret:Weibo_AppSecret
                             redirectUri:Default_Redirect_URL
                             weiboSDKCls:[WeiboSDK class]];
    [ShareSDK ssoEnabled:NO];
    
    //腾讯开放平台
    [ShareSDK connectQZoneWithAppKey:Tencent_AppKey
                           appSecret:Tencent_Secret
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    
    [ShareSDK connectQQWithQZoneAppKey:Tencent_AppKey
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    
    
    
    //导入QQ互联和QQ好友分享需要的外部库类型，如果不需要QQ空间SSO和QQ好友分享可以不调用此方法
    [ShareSDK importQQClass:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
    
    
    //导入微信需要的外部库类型，如果不需要微信分享可以不调用此方法
    [ShareSDK importWeChatClass:[WXApi class]];
    
    
    //开启QQ空间网页授权开关
    id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
    [app setIsAllowWebAuthorize:YES];
    
    
}

@end
