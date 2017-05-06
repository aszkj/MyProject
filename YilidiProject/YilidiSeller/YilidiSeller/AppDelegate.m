//
//  AppDelegate.m
//  YilidiSeller
//
//  Created by yld on 16/4/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "AppDelegate.h"
#import <Aspects/Aspects.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import "DLSellerLoginVC.h"
#import "BaiduLocationManage.h"
#import "DLBaseNavController.h"
#import "DLHomePageVC.h"
#import "GuideViewController.h"
#import "CHKeychain.h"
#import "GlobleConst.h"
#import "GeTuiSdk.h"
#import "Util.h"
#import "CordovaH5UrlManager.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "GlobleConst.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <UserNotifications/UserNotifications.h>
#import "BrandDataManager.h"
#import "GlobeMaco.h"


//测试推送环境配置
//#define kGtAppId           @"04B9WMdG7r8N44uzIXXzt4"
//#define kGtAppKey          @"PsXogOJtEw58IvhuBwEYA3"
//#define kGtAppSecret       @"4B7KstONhH7nZTlLzlPIDA"

///// 个推开发者网站中申请App时，注册的AppId、AppKey、AppSecret--开发
#define kGtAppId           @"k8mcsoh71y5anQ9JrouZi6"
#define kGtAppKey          @"cStr4aDsOy8XMLtraYBs0A"
#define kGtAppSecret       @"7YGnr9wG7QAsMbPMsbjRn1"



@interface AppDelegate ()<BMKGeneralDelegate,GeTuiSdkDelegate,UNUserNotificationCenterDelegate>
@property(nonatomic,strong)AVAudioPlayer *movePlayer ;
@end
BMKMapManager* _mapManager;
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
   
    [self _configureHookInfo];
    
    [self _configureKeyBoard];
    
    [self _configureLog];
    
    [self _configureBaiduLocation];
    
    [self _entrance];
    
    [self _openBaiduMap];
    
    [self _openGeTui];

//    [self _configureCordova];
    
//    [self _configureBrandDataManager];
   
    return YES;
}

- (void)_configureBrandDataManager {
    [[BrandDataManager sharedManager] startDownLoadBrandData];
}

- (void)_configureCordova {
    [[CordovaH5UrlManager sharedManager] beginDownLoadH5Url];
}


- (void)_openBaiduMap {
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"0WBEk1G81pwiAsRYzCSlH8fA09bjbqa8" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

- (void)_openGeTui {

    // 通过个推平台分配的appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    
    [GeTuiSdk runBackgroundEnable:YES];
    //如果不延时有时候就是不走获取token代理方法。。
    [self performSelector:@selector(registerUserNotification) withObject:self afterDelay:1];

    
}


#pragma mark - 用户通知(推送) _自定义方法
/** 注册用户通知 */
- (void)registerUserNotification {
    
    /*
     注册通知(推送)
     申请App需要接受来自服务商提供推送消息
     */
    
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        //iOS10特有
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        // 必须写代理，不然无法监听通知的接收与点击
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // 点击允许
                NSLog(@"注册成功");
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    NSLog(@"%@", settings);
                }];
            } else {
                // 点击不允许
                NSLog(@"注册失败");
            }
        }];
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >8.0){
    
    
                // 定义用户通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
                UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        
                // 定义用户通知设置
                UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
                [[UIApplication sharedApplication] registerForRemoteNotifications];
        
                // 注册用户通知 - 根据用户通知设置
                [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    }else if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
        //iOS8系统以下
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
    // 注册获得device Token
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    
 }




#pragma mark - 远程通知(推送)回调

/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *sellerToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    sellerToken = [sellerToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", sellerToken);
    
    
    NSString *usertoken = [kUserDefaults objectForKey:SELLERTOKEN];
    if (usertoken==nil) {
    [kUserDefaults setObject:sellerToken forKey:SELLERTOKEN];
    [kUserDefaults synchronize];
    
    }
    
    
    //向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:sellerToken];
}

/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"\n>>>[DeviceToken Error]:%@\n\n", error.description);
}


//10.0
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
        
        [self playNotification];
        
        completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
        
        
        [self playNotification];
    

    }
   
}

// 通知的点击事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 收到远程通知:%@",userInfo);
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    // Warning: UNUserNotificationCenter delegate received call to -userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler: but the completion handler was never called.
    completionHandler();  // 系统要求执行这个方法
    
}



#pragma mark - Background Fetch 接口回调
//后台刷新数据
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    /// Background Fetch 恢复SDK 运行
    
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
}

/** APP已经接收到“远程”通知(推送) - (App运行在后台/App运行在前台) */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    application.applicationIconBadgeNumber = 0; // 标签
     
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [GeTuiSdk resetBadge];
    
    NSLog(@"\n>>>[Receive RemoteNotification]:%@\n\n", userInfo);
}

//#apns通道---离线
/** APP已经接收到“远程”通知(推送) - 透传推送消息  */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    // 处理APN
    NSLog(@"\n>>>[Receive RemoteNotification - Background Fetch]:%@\n\n", userInfo);

    completionHandler(UIBackgroundFetchResultNewData);
}


#pragma mark - GeTuiSdkdelegate 注册回调，获取CID信息

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    
    NSString *userclientId = [kUserDefaults objectForKey:CLIENTID];
    if (userclientId==nil) {
        [kUserDefaults setObject:clientId forKey:CLIENTID];
        [kUserDefaults synchronize];
        
    }
    
    [self cacelbadge];
    [GeTuiSdk resetBadge];
    //每次进来app首页进行刷新数据
    [[NSNotificationCenter defaultCenter]postNotificationName:@"getHomeData" object:@"requestData"];
    
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    //个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}

////个推透传消息通道---在线
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    
    // [4]: 收到个推消息
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    
    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg:%@%@", taskId, msgId, payloadMsg, offLine ? @"<离线消息>" : payloadMsg];


    
    
    NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", payloadMsg);
    
    NSDictionary *data = [self dictionaryWithJsonString:payloadMsg];
    

    //根据类型做不同操作
    if ([data[@"pushMsgType"] isEqualToString:PUSHNOTIFYMSGTYPE]) {
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0){
            [self localNotifications];
        }else{
        
            [self registerLocalNotification:1];
        }
        [GeTuiSdk resetBadge];
    }
    
    
    
    
    // 汇报个推自定义事件
    [GeTuiSdk sendFeedbackMessage:90001 andTaskId:taskId andMsgId:msgId];
}


//10.0--本地通知
- (void)localNotifications{

    //通知内容类
    UNMutableNotificationContent * content = [UNMutableNotificationContent new];
    //设置通知请求发送时 app图标上显示的数字
//    content.badge = @1;
    //设置通知的内容
    content.body = @"老板,您有新订单了,请尽快处理。";
    //默认的通知提示音
    content.sound = [UNNotificationSound soundNamed:[[NSBundle mainBundle] pathForResource:@"new_order_tips" ofType:@"wav"]];
    
    //设置通知的标题
//    content.title = @"";
    //设置从通知激活app时的launchImage图片
//    content.launchImageName = @"lun";
    //设置1S之后执行
    UNTimeIntervalNotificationTrigger * trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
    UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:@"NotificationDefault" content:content trigger:trigger];
    

    
    //添加通知请求
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
    
  
}


- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


// ios10之前设置本地通知
- (void)registerLocalNotification:(NSInteger)alertTime {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    
    
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
    notification.repeatInterval = kCFCalendarUnitSecond;
    
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"老板,您有新订单了,请尽快处理。" forKey:@"key"];
    notification.userInfo = userDict;
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    } else {
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSDayCalendarUnit;
    }
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}




//// 本地通知回调函数，当应用程序在前台时调用
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"noti:%@",notification);

    [self playNotification];
  
}

- (void)playNotification{

    self.movePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"new_order_tips" ofType:@"wav"]] error:nil];
    self.movePlayer.volume =1;//0.0-1.0之间
    
    [self.movePlayer prepareToPlay];
    [self.movePlayer play];//播放
    
    
    // 这里真实需要处理交互的地方
    // 获取通知所带的数据
    //    NSString *notMess = [notification.userInfo objectForKey:@"key"];
    
    [Util ShowAlertWithOnlyMessage:@"老板,您有新订单了,请尽快处理。"];
    
    [self cacelbadge];
    
    // 在不需要再推送时，可以取消推送
    [self cancelLocalNotificationWithKey:@"key"];
}

- (void)cacelbadge {

    // 更新显示的徽章个数
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    
    badge =0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
}

// 取消某个本地推送通知
- (void)cancelLocalNotificationWithKey:(NSString *)key {
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;

    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[key];

            // 如果找到需要取消的通知，则取消
            if (info != nil) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;
            }
        }
    }
}






- (void)_configureBaiduLocation {
    
    [[BaiduLocationManage shareManage] startLocationBackBlock:^(CLLocation *location,NSString *city) {
        JLog(@"latitude -- %.4f",location.coordinate.latitude);
        JLog(@"longtitude -- %.4f",location.coordinate.longitude);
        JLog(@"city -- %@",city);
    } errorBlock:^(NSError *error) {
       JLog(@"city --");
    }];
}


- (void)_entrance {
    if (SESSIONID) {
        [self _enterMain];
        [self _requestUserInfo];
    }else{
        [self _enterLogin];
    }
}

- (void)_requestUserInfo {
    DDLogVerbose(@"请求用户信息。。");
    [AFNHttpRequestOPManager postWithParameters:nil subUrl:kUrl_GetUserInfo block:^(NSDictionary *result, NSError *error) {
        if (isEmpty(result[EntityKey])) {
            return;
        }
        NSString *invitationCode;
        if (isEmpty(result[EntityKey][@"invitationCode"])) {
            invitationCode = @"";
        }else{
            
            invitationCode = result[EntityKey][@"invitationCode"];
        }
        
        NSString *userImageUrl;
        if (isEmpty(result[EntityKey][@"userImageUrl"])) {
            userImageUrl = @"";
        }else{
            
            userImageUrl = result[EntityKey][@"userImageUrl"];
        }
        
        
        NSDictionary *loginDic =  @{@"beginBusinessHours":result[EntityKey][@"beginBusinessHours"],@"endBusinessHours":result[EntityKey][@"endBusinessHours"],@"storeName":result[EntityKey][@"storeName"],@"userMobile":result[EntityKey][@"userMobile"],@"userName":result[EntityKey][@"userName"],@"invitationCode":invitationCode,@"userImageUrl":userImageUrl,@"latitude":result[EntityKey][@"latitude"],@"longitude":result[EntityKey][@"longitude"],@"addressDetail":result[EntityKey][@"addressDetail"]};
        
        NSNumber *shareFlag = result[EntityKey][@"shareFlag"];
        [kUserDefaults setObject:shareFlag forKey:KShareStockKey];
        [kUserDefaults synchronize];
        
        
        [kUserDefaults setObject:loginDic forKey:HomeResponeData];
        [kUserDefaults synchronize];
        
        

    }];
}

- (void)_configureLog {
    // 实例化 lumberjack
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    // 允许颜色
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
}

- (void)_configureKeyBoard {
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];

}

- (void)_configureHookInfo {
#ifdef DEBUG
    [UIViewController aspect_hookSelector:@selector(viewDidAppear:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> aspectInfo) {
//                                   DDLogVerbose(@"view did appear: %@",                                   [aspectInfo instance]);
                               } error:NULL];
#else
    
#endif

    
}

- (void)_enterGuidePage {
    //引导页面
    GuideViewController *guideVC = [[GuideViewController alloc] init];
    self.window.rootViewController = guideVC;
}

//获取用户UUID,即使卸载程序还会存在，只有退出当前账户才重新生成
- (void)_enterLogin {
    DLSellerLoginVC *loginVc = [[DLSellerLoginVC alloc] init];
    DLBaseNavController *loginNav = [[DLBaseNavController alloc] initWithRootViewController:loginVc];
    self.window.rootViewController = loginNav;
}

- (void)_enterMain {
    
    DLHomePageVC *homeVC = [[DLHomePageVC alloc] init];
    DLBaseNavController *homeNav = [[DLBaseNavController alloc] initWithRootViewController:homeVC];
    self.window.rootViewController = homeNav;
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
    
    
    
    [GeTuiSdk clearAllNotificationForNotificationBar];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}







@end
