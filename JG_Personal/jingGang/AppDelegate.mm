//
//  AppDelegate.m
//  jingGang
//
//  Created by yi jiehuang on 15/5/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "AppDelegate.h"
#import "Header.h"
#import "userDefaultManager.h"
#import "ShoppingHomeController.h"
#import<SystemConfiguration/SCNetworkReachability.h>
#import "loginViewController.h"
#import "QBleClient.h"
#import "ThirdPlatformInfo.h"
#import <PgySDK/PgyManager.h>
#import "WeiboSDK.h"
#import <ShareSDK/ShareSDK.h>
#import "LKDBHelper.h"
#import "UIViewExt.h"
#import "APService.h"
#import "YTKKeyValueStore.h"
#import "GlobeObject.h"
#import "JGMessageManager.h"
#import "JGHealthTaskManager.h"
#import <QZoneConnection/ISSQZoneApp.h>
#import <QZoneConnection/QZoneConnection.h>
#import <AlipaySDK/AlipaySDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "IQKeyboardManager.h"
#import "VApiManager.h"
#import "OrderDetailController.h"
#import "Util.h"
#import "mapObject.h"
#import "KJShoppingAlertView.h"
#import "WSProgressHUD.h"
#import "ShoppingOrderDetailController.h"
#import "IntegralDetailViewController.h"
#import "DrinkWaterMoel.h"
#import "GetAwakeModel.h"
#import "LongTimeSeatReminderModel.h"
#import "JGPayResultController.h"
#import "UIAlertView+Extension.h"
#import "JGIntegralValueController.h"
#import "StartViewController.h"
#import "PushNofiticationController.h"
#import "JGActivityWebController.h"
#import "AppDelegate+JGActivity.h"

#define ISFISTRINSTALL @"ISFISTRINSTALL"
@interface AppDelegate ()
{
    BMKMapManager* _mapManager;
}
//判断是否在前台运行
@property (nonatomic,assign) BOOL flag;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *w = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = w;
    application.statusBarHidden = NO;
    [self.window makeKeyAndVisible];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 查询当前活动信息
    [self loadActivity];
    
    //百度地图
    [self setBaiduMapKey];
    
    //键盘初始化
    [self keyBoardManagerInit];
    
    //初始化第三方平台信息
    [self _initThirdPlatformInfo];
    
    //初始化数据库信息
    [self _initDataBase];
    
    //初始化消息管理模块
    [JGMessageManager shareInstances];
    
    //自定义消息通知监听
    [self customerMessageNotificationRigester];
    
    //注册本地通知
    [self localNotificationRegister];
    
    //即时访问天气信息
    if ([self connectedToNetwork]) {
        NSLog(@"no_connet");
    }
    
    //注册远程推送
    [self registerRemoteNotificationForJPushWithLauchOption:launchOptions];
    
    //判断是否第一次安装与版本号是否有变动
    [self checkupVersionDisplayGuidePageAndIsFisrtInstallApp];
    application.applicationIconBadgeNumber = 0;
    return YES;
}


#pragma mark ----判断是否第一次安装与版本号是否有变动，供启动引导页用
- (void)checkupVersionDisplayGuidePageAndIsFisrtInstallApp
{
    NSString *token = GetToken;
    //这里一进来要检查一下token是否存在，不存要要把接收推送的功能关掉，防止用户删除app后重新下载后在并未登陆的情况下还能接收到推送
    if (!token) {
        //退出登录需要设置不接收推送消息,暂时这样做
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    }
     //获取项目当前版本号
    NSString *versionNow = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    //第一次安装，并且把版本号存在本地
     NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    if ([self isFirstInstall]) {
       
        [userDef setObject:@"installed" forKey:ISFISTRINSTALL];
        
        [userDef setObject:versionNow forKey:versionOldNum];
        //设置引导页
        [self setStarLeadController];

    }else{
        //已经安装过了，取出存储在本地的版本号对比现在的版本号看是否更新
        NSString *strVersion = [userDef objectForKey:versionOldNum];
        
        //已经安装，但是版本号不相符,如果版本号不相符加载引导页
        if (![strVersion isEqualToString:versionNow]) {
            [userDef setObject:versionNow forKey:versionOldNum];
            [self setStarLeadController];
            
        }else{
            //版本号不相符则等待引导页加载结束后再签到
            //没有任何变动加载首页
            [self enterMain];
            // 查询用户签到情况
            [self queryUserDidCheck];
        }
    }
    [userDef synchronize];
}

//判断是否第一次安装
- (BOOL)isFirstInstall
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    if ([userDef objectForKey:ISFISTRINSTALL] == nil) {
        return YES;
    }
    return NO;
}
#pragma mark ---创建启动引导页面
- (void)setStarLeadController
{
    StartViewController *starVC = [[StartViewController alloc]init];
    NSArray *arrayStarImage;
    if (iPhone4) {
        arrayStarImage = [NSArray arrayWithObjects:@"guide_1_iphone4s",@"guide_2_iphone4s",@"guide_3_iphone4s",@"guide_4_iphone4s", nil];
    }else{
        arrayStarImage = [NSArray arrayWithObjects:@"guide_1",@"guide_2",@"guide_3",@"guide_4", nil];
    }
    starVC.arrayStarImage = arrayStarImage;
    self.window.rootViewController = starVC;
}



#pragma mark - 第三方键盘初始化
-(void)keyBoardManagerInit {
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}


#pragma mark - 自定义消息通知监听
-(void)customerMessageNotificationRigester{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
}

#pragma mark - 本地通知注册
-(void)localNotificationRegister{
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }//注册本地通知
}

#pragma mark - 注册远程推送-极光
-(void)registerRemoteNotificationForJPushWithLauchOption:(NSDictionary *)launchOptions{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];

    //是否在前台，在前台就不跳转到页面
    if (!self.flag) {
        NSString *messageTypeStr = userInfo[@"messageType"];
        UIViewController *controller;
        if ([messageTypeStr isEqualToString:@"integral"]) {//积分详情
            JGIntegralValueController *vc = [[JGIntegralValueController alloc]initWithControllerType:IntegralControllerType];
            
            controller = vc;
        }else if ([messageTypeStr isEqualToString:@"cloudMoney"]){//云币详情
            JGIntegralValueController *vc = [[JGIntegralValueController alloc]initWithControllerType:CloudValueControllerType];
            controller = vc;
        }
        
        NSString *strMyTypeID = userInfo[@"mType"];
        if ([strMyTypeID isEqualToString:@"2"] || [strMyTypeID isEqualToString:@"3"]) {
            PushNofiticationController *vc = [[PushNofiticationController alloc]init];
            vc.strPushUrl = userInfo[@"linkUrl"];
            if ([strMyTypeID isEqualToString:@"2"]) {//2是链接
                vc.urlType = InterLinkageControllerType;
            }else if ([strMyTypeID isEqualToString:@"3"]){//3是富文本,需要多传一个urlID
                vc.urlType = RichTextlControllerType;
                vc.strUrlID = userInfo[@"id"];
                vc.strControllerTitle = userInfo[@"title"];
            }
            controller = vc;
        }
        
        NSString *activityPushType = [NSString stringWithFormat:@"%@",userInfo[@"activityPushType"]];
        if ([activityPushType isEqualToString:@"activity"]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:@"春节活动" forKey:@"hotName"];
            NSString *strNewUrl = [NSString stringWithFormat:@"%@/newyear/cash_coupon.htm",Shop_url];
            JGActivityWebController *vc = [[JGActivityWebController alloc] initWithAdvertBO:nil withHeaderRequest:strNewUrl ApiBO:dic isPushType:YES];
            controller = vc;
        }
       
        if (controller) {
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:controller];
            nav.navigationBar.barTintColor = status_color;
            [self.window.rootViewController presentViewController:nav animated:YES completion:^{
                
            }];
        }
        application.applicationIconBadgeNumber = 0;
    }
    completionHandler(UIBackgroundFetchResultNewData);
}


#pragma mark - 自定义消息通知
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NSDictionary * userInfo = [notification userInfo];
    NSInteger messageType = [userInfo[@"extras"][@"messageType"] integerValue];
    if (messageType == 1) {//咨询
        [kNotification postNotificationName:Info_Message_Notification object:userInfo];
    }else if (messageType == 2){//通知，自定义消息
        [kNotification postNotificationName:Cutom_Message_Notification object:userInfo];
    }
}


#pragma mark - 第三方平台信息初始化
-(void)_initThirdPlatformInfo{
    // 友盟统计
    [MobClick startWithAppkey:MobClick_AppKey reportPolicy:BATCH  channelId:nil];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    //启动蓝牙模块
//    [[qBleClient sharedInstance] pubControlSetup];
    
    //启动蒲公英模块
    [[PgyManager sharedPgyManager] startManagerWithAppId:PU_GONG_YING_APPID];
    
    
    [[PgyManager sharedPgyManager] setEnableFeedback:NO];
    
    
    //设置用户反馈界面的颜色
    [[PgyManager sharedPgyManager] setThemeColor:kGetColor(90, 196, 241)];
    
    
    
    //检查版本更新
    [[PgyManager sharedPgyManager] checkUpdate];
    
    
    //ShareSDK 模块
    [ShareSDK registerApp:Mob_share_key];

    
    //微信模块
    [ShareSDK connectWeChatWithAppId:Weixin_AppID appSecret:Weixin_AppSecret wechatCls:[WXApi class]];
    
    //微信支付appid
//    [WXApi registerApp:@"wx1370b545c166cc0d"];
    [WXApi registerApp:@"wx5789cef4a9508420"];
    
    
//    //新浪微博//
    [ShareSDK connectSinaWeiboWithAppKey:Weibo_Appkey appSecret:Weibo_AppSecret redirectUri:Default_Redirect_URL];
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
    
    
//    //开启QQ空间网页授权开关
//    id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
//    [app setIsAllowWebAuthorize:YES];
    
}//初始化第三方平台的信息


#pragma mark - 初始化数据库
-(void)_initDataBase{

    LKDBHelper *lkDBHelper = [LKDBHelper getUsingLKDBHelper];
    [lkDBHelper setDBName:db_path];
    
    //喝水model表
    [lkDBHelper createTableWithModelClass:[DrinkWaterMoel class]];
    
    //起床提醒表
    [lkDBHelper createTableWithModelClass:[GetAwakeModel class]];
     
    //久坐提醒表
    [lkDBHelper createTableWithModelClass:[LongTimeSeatReminderModel class]];
}


#pragma mark - shareSDK回调处理
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
//    return [ShareSDK handleOpenURL:url wxDelegate:self];
      return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{

    NSLog(@"平台 url %@",url.absoluteString);
    
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"ali pay result = %@",resultDic);
        [self goToOrderDetailVC];
    }];
    
    NSString *handUrlStr = url.absoluteString;
    if ([handUrlStr rangeOfString:@"pay"].length > 0) {//说明有支付回调，支付宝可以对回调不做处理，微信需要
        return [WXApi handleOpenURL:url delegate:self];
        
    }else{
        return [ShareSDK handleOpenURL:url
                     sourceApplication:sourceApplication
                            annotation:annotation
                            wxDelegate:self];
    }
    
}

#pragma mark - 微信支付回调结果
-(void)onResp:(BaseResp *)resp{
//    VApiManager *_vapManager = [[VApiManager alloc] init];

    if (self.getWXCode) {
        if ([resp isKindOfClass:[SendAuthResp class]]) {
            SendAuthResp *req = (SendAuthResp *)resp;
            BLOCK_EXEC(self.wxCodeBlock,[req code]);
            return;
        }
    }
    NSString *strTitle;
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    BOOL isSucess = NO;
    BOOL isCanceled = NO;
    if ([resp isKindOfClass:[PayResp class]]) {
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode) {
            case WXSuccess:
            {
                NSLog(@"wxi pay 支付结果: 成功!");
                strTitle = @"支付成功";
                isSucess = YES;
            }
                break;
            case WXErrCodeCommon:
            { //签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等
                
                NSLog(@"wxi pay  支付结果: 失败!");
                strTitle = @"支付失败";
            }
                break;
            case WXErrCodeUserCancel:
            { //用户点击取消并返回
                NSLog(@"wxi pay  支付结果: 取消!");
                isCanceled = YES;
                strTitle = @"取消支付";
            }
                break;
            case WXErrCodeSentFail:
            { //发送失败
                NSLog(@"发送失败");
                strTitle = @"发送失败";
            }
                break;
            case WXErrCodeUnsupport:
            { //微信不支持
                NSLog(@"微信不支持");
                strTitle = @"微信不支持";
            }
                break;
            case WXErrCodeAuthDeny:
            { //授权失败
                NSLog(@"授权失败");
                strTitle = @"微信不支持";
            }
                break;
            default:
                break;
        }
//        [Util ShowAlertWithOnlyMessage:strTitle];
        
        if (resp.errCode != WXSuccess) {
            [UIAlertView xf_showWithTitle:strTitle message:nil delay:1.5 onDismiss:^{
                
            }];
        }
        
        if (isSucess) {
            
//            if (self.jingGangPay == ClouldPay) {
//                // 如果是云币充值
//                
//            }
            
            //开启订单状态轮询
            _orderStatusQuery = [[KJOrderStatusQuery alloc] initWithQueryOrderID:self.orderID];
            if (self.jingGangPay == ClouldPay) {
              // 如果是云币充值
                [WSProgressHUD showShimmeringString:@"正在查询订单状态.." maskType:WSProgressHUDMaskTypeBlack];
                [_orderStatusQuery beginRollingQueryCloudPayResultIntervalTime:2.0 rollingResult:^(BOOL success, id response) {
                    
                    [self _queryCloudPayResult:success response:response];
                    
                }];
                
            }else {
                if (self.jingGangPay == O2OPay) {//服务订单查询
                    _orderStatusQuery.isServiceOrderQuery = YES;
                }else if (self.jingGangPay == IntegralPay){//积分订单查询
                    _orderStatusQuery.isIntegralGoodsOrderQuery = YES;
                }
                //            [WSProgressHUD showWithMaskType:WSProgressHUDMaskTypeBlack];
                [WSProgressHUD showShimmeringString:@"正在查询订单状态.." maskType:WSProgressHUDMaskTypeBlack];
                [_orderStatusQuery beginRollingQueryWithIntervalTime:2.0 rollingResult:^(BOOL success) {
                    [self _queryDealResult:success];
                }];
            }
            
           
        }else{//失败，
            //进入订单详情
            if (!isCanceled) {//支付失败，但不是取消
                [Util ShowAlertWithOnlyMessage:strTitle];
                [self performSelector:@selector(goToOrderDetailVC) withObject:nil afterDelay:2.0];
            }
        }
    }
}

- (void)_queryCloudPayResult:(BOOL)success response:(id)response {
    if (success) {
        [WSProgressHUD dismiss];
        [KJShoppingAlertView showAlertTitle:@"支付成功" inContentView:self.window];
        [self performSelector:@selector(gotoCloudPayResult:) withObject:response afterDelay:2.0];

    }
}

- (void)gotoCloudPayResult:(id)response {
    JGPayResultController *resultController = [[JGPayResultController alloc] initWithResposeObj:response];
    [self.payCommepletedTransitionNav pushViewController:resultController animated:YES];

}

-(void)_queryDealResult:(BOOL)sucess{
    
    if (sucess) {
        [WSProgressHUD dismiss];
        [KJShoppingAlertView showAlertTitle:@"支付成功" inContentView:self.window];
        //进入订单详情
        [self performSelector:@selector(goToOrderDetailVC) withObject:nil afterDelay:2.0];
    }
    
}


#pragma mark - 进入订单详情页
-(void)goToOrderDetailVC{
    if (self.jingGangPay == ShoppingPay) {//商城的支付，跳商品订单详情
        //进入订单详情
        OrderDetailController *orderDetailVC = [[OrderDetailController alloc] init];
        orderDetailVC.orderID = self.orderID;
        [self.payCommepletedTransitionNav pushViewController:orderDetailVC animated:YES];
    }else if(self.jingGangPay == O2OPay){//服务支付，服务的订单详情
        ShoppingOrderDetailController *serviceOrderVC = [[ShoppingOrderDetailController alloc] init];
        serviceOrderVC.orderId = self.orderID.integerValue;
        [self.payCommepletedTransitionNav pushViewController:serviceOrderVC animated:YES];
    }else if (self.jingGangPay == IntegralPay){
        IntegralDetailViewController *integralOrderVC = [[IntegralDetailViewController alloc] init];
        integralOrderVC.orderId = self.orderID;
        [self.payCommepletedTransitionNav pushViewController:integralOrderVC animated:YES];
    }else if (self.jingGangPay == ClouldPay) {
        [self.payCommepletedTransitionNav pushViewController:[UIViewController new] animated:YES];
    }
}

- (void)login
{
    [self enterMain];
}



-(void)beGinLogin
{
    [userDefaultManager SetLocalDataObject:nil key:@"Token"];
    loginViewController * loginVc = [[loginViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:loginVc];
    self.window.rootViewController = nav;

}

#pragma mark - 直接进入主页
-(void)enterMain{
    
    AppDelegate * app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [app gogogoWithTag:0];
}



-(void)gogogoWithTag:(int)tag
{
    [userDefaultManager SetLocalDataString:@"58" key:@"innerRadius"];
    [userDefaultManager SetLocalDataString:@"78" key:@"outerRadius"];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
//    individualCenterViewController * left = [individualCenterViewController instance];
    individualCenterViewController * left = [[individualCenterViewController alloc] init];
//    CustomTabBar *tabbarController = [CustomTabBar instance];
    CustomTabBar *tabbarController = [[CustomTabBar alloc] init];
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:tabbarController leftDrawerViewController:left];
    [tabbarController setSelectedTab:tag];
    CGFloat width = ((375 - 59) / 375.0 ) * kScreenWidth;
    [_drawerController setMaximumLeftDrawerWidth:width];
    [_drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
    MMExampleDrawerVisualStateManager *manager = [MMExampleDrawerVisualStateManager sharedManager];
    manager.leftDrawerAnimationType = MMDrawerAnimationTypeSlideAndScale;
    manager.rightDrawerAnimationType = MMDrawerAnimationTypeSlideAndScale;
    
    self.window.rootViewController = self.drawerController;
}



- (BOOL)connectedToNetwork
{
    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    
    struct sockaddr_storage zeroAddress;//IP地址
    
    bzero(&zeroAddress, sizeof(zeroAddress));//将地址转换为0.0.0.0
    zeroAddress.ss_len = sizeof(zeroAddress);//地址长度
    zeroAddress.ss_family = AF_INET;//地址类型为UDP, TCP, etc.
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return NO;
    }
    //根据获得的连接标志进行判断
    
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable&&!needsConnection) ? YES : NO;
    
    

}


- (void)applicationWillResignActive:(UIApplication *)application {
    [BMKMapView willBackGround];
    
    //应用程序将要退出时，进行未读消息处理
    [[JGMessageManager shareInstances] saveUnreadInfoMsg];
    
    //任务信息缓存
    [[JGHealthTaskManager shareInstances] saveTaskInfo];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}



- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    self.flag = NO;
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    application.applicationIconBadgeNumber = 0;
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    self.flag = YES;
    
    [self loadActivity];
    
    [BMKMapView didForeGround];
    
    double delayInSeconds = 0.0;//每次程序启动之后检测appStore里面的版本号
    double delayInSeconds2 = 2.0;//2秒之后发送反馈信息
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds2 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //启动之后需要做的
        
    });
    
    dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
        //两秒之后需要做的
        
    });
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    // open app store link
    NSString * from = [notification.userInfo valueForKey:@"from"];
    if (([from isEqualToString:@"commont"])) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView * alertVc = [[UIAlertView alloc]initWithTitle:@"提示" message:@"麦客客户端有新的版本，点击到App Store升级。" delegate:self cancelButtonTitle:@"暂不升级" otherButtonTitles:@"现在就去", nil];
            [alertVc show];

        });
    }
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            NSString * appStoreURL = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",APP_STORE_ID];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreURL]];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark ---weatherManagerDelegate---
- (void)DidFailWithError:(NSError *)error {
    
}

- (void) DidFinishLoadingWithWeather:(weather *)weather
{
    [userDefaultManager SetLocalDataString:weather.city key:@"city"];
    [userDefaultManager SetLocalDataString:weather.minWeather key:@"minWeather"];
    [userDefaultManager SetLocalDataString:weather.maxWeather key:@"maxWeather"];
    [userDefaultManager SetLocalDataString:weather.weather key:@"weather"];
    [userDefaultManager SetLocalDataString:weather.wind key:@"weather_wind"];
    [userDefaultManager SetLocalDataString:weather.pm_num key:@"pm_num"];
    [userDefaultManager SetLocalDataString:weather.sd_num key:@"sd_num"];
    [userDefaultManager SetLocalDataString:weather.pm_lev key:@"pm_lev"];
}


//推送
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    [APService registerDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSLog(@"---userInfo  --- 推送--%@",userInfo);
    if (userInfo) {

        //本地通知提醒
//        [self receiveRemoteNotificationUsingLocationNotifyWithInfo:userInfo];
        [APService handleRemoteNotification:userInfo];
        //通知消息管理者
        [self notifyMsgManagerWithInfo:userInfo];
    }
}


#pragma mark - 收到远程通知后，用本地通知提醒
-(void)receiveRemoteNotificationUsingLocationNotifyWithInfo:(NSDictionary *)info{

    UILocalNotification *notification = [[UILocalNotification alloc] init];
//    AUTO_RELEASE(notification);
    //设置10秒之后
    NSDate *pushDate = [NSDate dateWithTimeIntervalSinceNow:0];
    if (notification != nil) {
        // 设置推送时间
        notification.fireDate = pushDate;
        // 设置时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
        // 设置重复间隔
        notification.repeatInterval = kCFCalendarUnitDay;
        // 推送声音
        notification.soundName = UILocalNotificationDefaultSoundName;
        // 推送内容
        notification.alertBody = info[@"alert"];
        //显示在icon上的红色圈中的数子
//        notification.applicationIconBadgeNumber = [info[@"badge"] integerValue];
        //设置userinfo 方便在之后需要撤销的时候使用
        NSDictionary *infoDic = [NSDictionary dictionaryWithObject:@"name" forKey:@"key"];
        notification.userInfo = infoDic;
        //添加推送到UIApplication
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:notification];   
    
    }
}

#pragma mark - 消息推送来，通知消息管理者
-(void)notifyMsgManagerWithInfo:(NSDictionary *)info{
    
    //向消息管理者发送通知，消息可能是不同类型，资讯或者公告，由消息管理者处理
    [[NSNotificationCenter defaultCenter] postNotificationName:Info_Message_Notification object:nil userInfo:info];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) setBaiduMapKey
{
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"blrQEI8qQsIqVR33j9wdXUWQ" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

#pragma mark - 验证百度地图是否授权成功
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

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    // 1.取消下载
    [mgr cancelAll];
    
    // 2.清除内存中的所有图片
    [mgr.imageCache clearMemory];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kPushImageUrlKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

-(void)dealloc {
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kPushImageUrlKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
