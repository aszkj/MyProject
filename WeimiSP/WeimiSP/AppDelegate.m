//
//  AppDelegate.m
//  weimi
//
//  Created by 鹏 朱 on 16/1/18.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "AppDelegate.h"
#import "XKJHNavRootController.h"
#import "FileMangeHelper.h"
#import "NSDate+Addition.h"
#import "XKJHBaseNavigationBar.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "Message.pb.h"
#import "Systemmessage.pb.h"
#import "JSONKit.h"
#import "KeyChainManager.h"
#import "IQKeyboardManager.h"
#import "AddressBookHelper.h"
#import "LoginController.h"
#import "WEMEApiClient.h"
#import "WEMEUsercontrollerApi.h"
#import "RemoteNotificationManage.h"
#import "FileMangeHelper.h"
#import <Reachability.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AFOAuth2Manager.h>
#import "BaiduLocationManage.h"
#import "NSString+MD5.h"
#import "SessonContentModel.h"
#import "DatabaseCache.h"
#import "iflyMSC/IFlyMSC.h"
#import "UploadFile.h"
#import "GuideViewController.h"
#import "ChatViewController.h"
#import "AcceptOrdePromptView.h"

#define  KReconnectionTime          2
#define  KCustomErrorDomain @"cn.com.Thinker.VC.WeimiSP"


@interface AppDelegate ()<BMKGeneralDelegate>

@property (nonatomic, strong) NSString *sysCode;
@property (nonatomic, assign) NSInteger connectTime;
@property (nonatomic, assign) UIBackgroundTaskIdentifier bgTask;
@property (nonatomic, assign) BOOL isBackground;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [application setApplicationIconBadgeNumber:0];
    _isBackground = NO;
    //后台播放音频设置
    NSError *error;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:&error];
    [session setCategory:AVAudioSessionCategoryPlayback error:&error];
    
    self.hasConnectToIMserver = NO;
    self.isConnectingIMserver = NO;

    //开启百度定位
    [self setBaiduMapKey];
    
    [self initApiClient];
    [self initInfo];
    [self InitIFlySetting];
    
    if (IsEmpty(GetToken)) {
        [self endterLoginPage];
    }else {
        [self initRootUI];
    }
    
    if (sysVersion > 7.0)
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
    if (![[kUserDefaults objectForKey:@"localVersion"] isEqualToString:[Util appVersion]]) {
        self.window.rootViewController.view.hidden = YES;
        [self.window.rootViewController presentViewController:[[GuideViewController alloc] init] animated:NO completion:^{
            self.window.rootViewController.view.hidden = NO;
        }];
        [kUserDefaults setObject:[Util appVersion] forKey:@"localVersion"];
    }
    
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];

    return YES;
}
- (void)setBaiduMapKey
{
    BMKMapManager * mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [mapManager start:@"y3DVS3ZrB4DO0iqaag44HT27" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}
#pragma mark - BMKGeneralDelegate
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

- (void)endBackgroundTask {
    
    [self disConnect];
    [[UIApplication sharedApplication] endBackgroundTask:_bgTask];
    _bgTask = UIBackgroundTaskInvalid;

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    _isBackground = NO;
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    
    _isBackground = NO;

    if (_bgTask != UIBackgroundTaskInvalid){
        
        [[UIApplication sharedApplication] endBackgroundTask:_bgTask];
        _bgTask = UIBackgroundTaskInvalid;

    }
    
    if (!IsEmpty(GetToken)) {
        [self performSelectorInBackground:@selector(connectToServer) withObject:nil];
    }
    
//    if ([UIApplication sharedApplication].applicationIconBadgeNumber > 0) {
    
        if (_mainController.acceptOrdePromptView.isHidden) {
            [_mainController waitCompleteOrderAPIOfNoTip];
            [_mainController WaitAcceptOrderAPI];
        }
//    }
}

//开启后台十分钟
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    _isBackground = YES;

    UIApplication* app = [UIApplication sharedApplication];
    _bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        
        [self endBackgroundTask];
    }];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
    _isBackground = YES;
    [self disConnect];
}

-(AcceptOrdeController *)mainController
{
    if (!_mainController) {
        _mainController = [[AcceptOrdeController alloc] init];
    }
    return _mainController;
}

- (void)initRootUI
{

    XKJHNavRootController *rootNavi = [[XKJHNavRootController alloc] initWithRootViewController:self.mainController];
    self.window.rootViewController = rootNavi;
    
}

-(void)setTabBarHidden:(BOOL)tabBarHidden
{
    _tabBarHidden = tabBarHidden;
//    _tabBarController.tabBarCustomView.hidden = tabBarHidden;
}

//开启百度定位
/**
 *  开启百度定位，5分钟定位一次并上传服务器
 */
- (void)startBaiduLocation {
    [self performSelector:@selector(startBaiduLocation) withObject:self afterDelay:(5 * 60)];
    
    if (!IsEmpty(GetToken)) {
        WEAK_SELF
        [[BaiduLocationManage shareManage] setBaiduLocationBlock:^(BMKUserLocation *location){
            
            [weak_self uploadLocationInfo];
        }];
    }
}

//发消息
- (void)sendMessage:(ProtoMessage *)message {
    
    NSData *data = [message data];
    [self.session publishData:data onTopic:kTopic];
    
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    
    [application registerForRemoteNotifications];
    
}

#endif

-(void)endterLoginPage {
    
    LoginController *loginVC = [[LoginController alloc] init];
    XKJHNavRootController *nav = [[XKJHNavRootController alloc] initWithRootViewController:loginVC];

    self.window.rootViewController = nav;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // 新获取的deviceToken
    NSString* newToken = [deviceToken description];
    newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [[RemoteNotificationManage sharedRemoteNotificationManage] registerForRemoteNotificationsWithDeviceToken:newToken];
    
    self.deviceToken = newToken;
    
    NSString *clientId = [KeyChainManager getDeviceToken];
    if (IsEmpty(clientId)) {
        self.clientId = newToken;
        [KeyChainManager setDeviceToken:newToken];
    } else {
        self.clientId = clientId;
    }

    NSString *oldDeviceToken = [kUserDefaults objectForKey:@"KDeviceToken"];
    if (!IsEmpty(newToken) && (IsEmpty(oldDeviceToken) || ![oldDeviceToken isEqualToString:newToken])) {
        
        [kUserDefaults setObject:newToken forKey:@"KDeviceToken"];
        [kUserDefaults synchronize];
        
        if (!IsEmpty(GetToken)) {
            [self uploadApnToken];
        }
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    [application cancelAllLocalNotifications];
    [application setApplicationIconBadgeNumber:0];
    
    [[RemoteNotificationManage sharedRemoteNotificationManage] failToRegisterForRemoteNotificationsWithError:error];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [[RemoteNotificationManage sharedRemoteNotificationManage] receiveRemoteNotification:userInfo];
    
    NSLog(@"aps:%@",userInfo);
    [application setApplicationIconBadgeNumber:[userInfo[@"aps"][@"badge"] integerValue]];
    
    if (_mainController.acceptOrdePromptView.isHidden) {
        [_mainController waitCompleteOrderAPIOfNoTip];
        [_mainController WaitAcceptOrderAPI];
    }
    if ([[userInfo objectForKey:@"type"] isEqualToString:@"system"]) {
        
        if ([[userInfo objectForKey:@"sysCode"] isEqualToString:@"10000"]) {

            if (_mainController.acceptOrdePromptView.isHidden) {
                [_mainController waitCompleteOrderAPIOfNoTip];
                [_mainController WaitAcceptOrderAPI];
            }

        } else if ([[userInfo objectForKey:@"sysCode"] isEqualToString:@"10001"]) {
            
            [_mainController hidePopverView];

        }
        
    } else if ([[userInfo objectForKey:@"type"] isEqualToString:@"chat"]) {
        [self didReceiveRemoteNotification:nil];
    }
}

- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if (![self.window.rootViewController isKindOfClass:[UINavigationController class]]) { return; }
    UINavigationController *rootNav = (UINavigationController *)self.window.rootViewController;
    for (UIViewController *vc in rootNav.viewControllers) {
        if ([vc isKindOfClass:[ChatViewController class]]) {
            ChatViewController *chatVC = (ChatViewController *)vc;
            [rootNav popToViewController:chatVC animated:NO];
            [chatVC pullOfflineMessage];
            return;
        }
    }
}

#pragma mark - getter

- (NSString *)currentUser {
    
    return [NSString stringWithFormat:@"I_%@_%@", [WEMEConfiguration sharedConfig].credential.accessToken,[Util createTimeIntervalOfNoRandomWithDate:[NSDate date]]];
}

- (NSString *)topic {
    
    return [NSString stringWithFormat:@"%@_topic",[WEMEConfiguration sharedConfig].credential.accessToken];
}

- (NSString *)sysTopic {
    
    return [NSString stringWithFormat:@"%@_systopic",[WEMEConfiguration sharedConfig].credential.accessToken];
}

#pragma mark - private methord

//mqtt连接方法
- (void)connectToServer
{
    if (!_hasConnectToIMserver && !_isConnectingIMserver) {
        
        self.session = [[MQTTSession alloc] initWithClientId:self.currentUser];
        self.session.delegate = self;
        self.isConnectingIMserver = YES;
        [self.session connectToHost:kIP port:KPort];
    }
}

- (void)connectToServerInBackground {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //        [self performSelectorInBackground:@selector(connectToServer) withObject:nil];

        [self performSelectorOnMainThread:@selector(connectToServer) withObject:nil waitUntilDone:YES];
        
    });
    
}

- (void)reconnection {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self performSelectorOnMainThread:@selector(connectToServer) withObject:nil waitUntilDone:YES];

//        [self performSelectorInBackground:@selector(connectToServer) withObject:nil];
        
    });
}

- (void)disConnect
{
    [self.session close];
    self.session.delegate = nil;
    self.session = nil;
    _hasConnectToIMserver = NO;
    _isConnectingIMserver = NO;
}

// 上传通讯录
- (void)uploadPhonesInfo {

    [[UploadFile shareInstance] uploadAddressBook];
    //    NSString *phones = [AddressBookHelper getPhones];
    //    NSArray *phonesList = [phones componentsSeparatedByString:@","];
    
    NSArray *phonesList = @[@"18098768393",@"18098768333",@"18098762393",@"18091238393",@"18045646593",@"18091238855",@"18098798643",@"18093453455"];
    
    [[WEMEUsercontrollerApi sharedAPI] addressbookUsingPOSTWithCompletionBlock:phonesList completionHandler:^(WEMESimpleResponse *output, NSError *error) {
        
        //        WEMESimpleResponse *success = output;
        DDLogInfo(@"上传通讯录:%@ error:%@",output,error);
    }];
}

// 上传地理位置信息
- (void)uploadLocationInfo {

    WEMEPoint *point = [[WEMEPoint alloc] init];
    CLLocationCoordinate2D location = [[BaiduLocationManage shareManage] currentLocation].location.coordinate;
    point.x = [NSNumber numberWithDouble:location.longitude];
    point.y = [NSNumber numberWithDouble:location.latitude];

    if ([point.x doubleValue] > 0 && [point.y doubleValue] > 0) {
        
        [[WEMEUsercontrollerApi sharedAPI] geoUsingPOSTWithCompletionBlock:point completionHandler:^(WEMESimpleResponse *output, NSError *error) {
            
            
        }];
    }
}

/**
 *  上传apnToken
 */
- (void)uploadApnToken {
    
    if (!IsEmpty([[[WEMEConfiguration sharedConfig] credential] accessToken]) && !IsEmpty(self.deviceToken)) {
        
        WEMEApnRequest *request = [[WEMEApnRequest alloc] init];
        request.clientId = [self.clientId MD5];
        request.apnToken = self.deviceToken;
        
        [[WEMEUsercontrollerApi sharedAPI] apnUsingPOSTWithCompletionBlock:request completionHandler:^(WEMESimpleResponse *output, NSError *error) {
            
        }];
    }
}

- (void)backPlatformBtn:(UIButton *)sender {
    
    UIAlertView *alerView = [[UIAlertView alloc ]initWithTitle:@"提示" message:[NSString stringWithFormat:@"apnToken:%@\nclientid:%@",self.deviceToken,self.clientId] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [[alerView rac_buttonClickedSignal] subscribeNext:^(NSNumber *indexNumber) {
//        NSInteger index = indexNumber.integerValue;
        
    }];
    
    [alerView show];
    
}

- (void)InitIFlySetting {
    
    //设置sdk的log等级，log保存在下面设置的工作路径中
    [IFlySetting setLogFile:LVL_ALL];
    
    //打开输出在console的log开关
    [IFlySetting showLogcat:YES];
    
    //设置sdk的工作路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    [IFlySetting setLogFilePath:cachePath];
    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    
}

//初始化api接口
- (void)initApiClient {
    
    WEMEConfiguration *config = [WEMEConfiguration sharedConfig];
    config.host = kApiUrl;

    if (!IsEmpty(GetToken)) {
        
        AFOAuthCredential *credential = [[AFOAuthCredential alloc] initWithOAuthToken:GetToken tokenType:@"bearer"];
        config.credential = credential;
        config.debug = YES;
        
        //注册远程通知
        [[RemoteNotificationManage sharedRemoteNotificationManage] registerNotification];

    } else {
        
        NSURL *baseURL = [NSURL URLWithString:authUrl];
        AFOAuth2Manager *OAuth2Manager =
        [[AFOAuth2Manager alloc] initWithBaseURL:baseURL
                                        clientID:KClientID
                                          secret:KSecret];
        
        [OAuth2Manager authenticateUsingOAuthWithURLString:@"/oauth/token"                                                              scope:@""
                                                   success:^(AFOAuthCredential *credential) {

                                                       WEMEConfiguration *config = [WEMEConfiguration sharedConfig];
                                                       config.credential = credential;
                                                       
                                                       //注册远程通知
                                                       [[RemoteNotificationManage sharedRemoteNotificationManage] registerNotification];

                                                   }
                                                   failure:^(NSError *error) {
                                                       
                                                       NSLog(@"Error: %@", error);
                                                   }];
    }
}

- (void)initIMServerInfo {
    [self initReachability];
}

//初始化数据
- (void)initInfo {
    
    _reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];

    self.openSound = YES;
    
    //创建本地数据库
    [[FileMangeHelper shareInstance] createDatabaseFolder];
    [[DatabaseCache shareInstance] createDBWithPath:[[DatabaseCache shareInstance] getDbPath]];

    NSString *clientId = [KeyChainManager getDeviceToken];
    self.clientId = clientId;
}

//初始化网络监测
- (void)initReachability {
    
    WEAK_SELF
    _reach.reachableBlock = ^(Reachability*reach) {
        
        if (!weak_self.hasConnectToIMserver && !weak_self.isConnectingIMserver) {
            
            _connectTime = 0;
            weak_self.isConnectingIMserver = NO;
            
            if (!IsEmpty(GetToken)) {
                [weak_self reconnection];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{

            NSDictionary *parameterDic = [[NSDictionary alloc] initWithObjectsAndKeys:@1,KMessageParameter, nil];
            [kNotification postNotificationName:kNotificationNetworkChangedMessage object:nil userInfo:parameterDic];
        });
    };
    
    _reach.unreachableBlock = ^(Reachability*reach) {
        
        if (weak_self.hasConnectToIMserver) {
            
            weak_self.isConnectingIMserver = NO;
            weak_self.session.delegate = nil;
            weak_self.session = nil;
            weak_self.hasConnectToIMserver = NO;
            weak_self.isConnectingIMserver = NO;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{

            NSDictionary *parameterDic = [[NSDictionary alloc] initWithObjectsAndKeys:@0,KMessageParameter, nil];
            [kNotification postNotificationName:kNotificationNetworkChangedMessage object:nil userInfo:parameterDic];

        });
    };
    
    [_reach startNotifier];
    
}

- (void)userExit {
    [kUserDefaults removeObjectForKey:Token];
    [kUserDefaults synchronize];
    [self initApiClient];
    [self disConnect];
    //清空聊天消息
    [[DatabaseCache shareInstance] DeleteAllByTableName:KTableNameOfSessionContent];
    
    LoginController *loginVC = [[LoginController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self.window.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:^{
        
    }];
    self.window.rootViewController = nav;
}

//测试注册接口
- (void)testRegisterInterface {
    
    [[WEMEUsercontrollerApi sharedAPI] regsiterUsingPOSTWithCompletionBlock:@"16777777777" password:@"123456" nickname:@"17777777777" idcode:@"123456" completionHandler:^(WEMESimpleResponse *output, NSError *error) {
        
        [self testLoginInterface];

    }];
}

//测试登录接口
- (void)testLoginInterface {
    
    NSURL *baseURL = [NSURL URLWithString:authUrl];
    AFOAuth2Manager *OAuth2Manager =
    [[AFOAuth2Manager alloc] initWithBaseURL:baseURL
                                    clientID:KClientID
                                      secret:KSecret];
    
    [OAuth2Manager authenticateUsingOAuthWithURLString:@"/oauth/token" username:@"16777777777" password:@"123456" scope:@"" success:^(AFOAuthCredential *credential) {
        
        NSLog(@"Token: %@", credential.accessToken);
        WEMEConfiguration *config = [WEMEConfiguration sharedConfig];
        config.credential = credential;
        
    } failure:^(NSError *error) {
        
    }];

}
//mqtt发消息
- (void)subscribeTopic {
    
    [self.session subscribeTopic:self.topic];
    [self.session subscribeTopic:self.sysTopic];
    
}

//收到mqtt系统消息
- (void)handleResponseSystemMessage:(ProtoSystemMessage *)message {
    
    if (IsEmpty(message)) return;
    
//    NSArray *argsArray = message.args;
//    NSArray *userListArray = message.userList;

    
//    if (message.feedUnPull) {
//        //刷新首页主题
//        [kNotification postNotificationName:kPullFeedNotification object:nil userInfo:nil];
//    }
//    
//    if (message.reciveFeedUnPull) {
//        //需要刷新发现主题
//        [kNotification postNotificationName:kPullReciveFeedNotification object:nil userInfo:nil];
//    }
//    
//    if (message.myReplyUnpull) {
//        //我回复消息,发现界面需要刷新
//        [kNotification postNotificationName:kPullMyReplyNotification object:nil userInfo:nil];
//    }
//    
//    if (message.myFeedReplyUnPull) {
//        //别人有新回复,首页需要刷新回复
//        [kNotification postNotificationName:kPullMyFeedReplayNotification object:nil userInfo:nil];
//    }
}

//收到mqtt消息
- (void)handleResponseMessage:(ProtoMessage *)message {
    
    if (!IsEmpty(message)) {
        //处理消息
        [self deliverMessage:message];
        
        /*NSString *code = message.message.content.code;
        if (![code isEqualToString:KParameter1006] && ![code isEqualToString:KParameter1007] && ![code isEqualToString:KParameter1008]) {
            
            //处理消息
            [self deliverMessage:message];
        }
        
        if ([code isEqualToString:KParameter1001]) {
            
        } else if ([code isEqualToString:KParameter1001]) {
            
            [kUserDefaults setObject:@"" forKey:Token];
            [kUserDefaults synchronize];

        } else if ([code isEqualToString:KParameter1004]) {
            
            if (!IsEmpty(message.accessToken)) {
                
                [kUserDefaults setObject:message.accessToken forKey:Token];
                WEMEConfiguration *config = [WEMEConfiguration sharedConfig];
                config.credential = [[AFOAuthCredential alloc] initWithOAuthToken:message.accessToken tokenType:@"bearer"] ;
                [kUserDefaults synchronize];
            }

        } else if ([code isEqualToString:KParameter1005]) {
            
            //开始百应之旅
        } else if ([code isEqualToString:KParameter1006]) {
            
        } else if ([code isEqualToString:KParameter1007]) {
            
            //通讯录信息
            
        } else if ([code isEqualToString:KParameter1008]) {
            
            //地理位置信息
            
            
        } else {
            
        }*/
    }
}

//把消息传递到聊天页面
- (void)deliverMessage:(ProtoMessage *)message {
    
    if (message.message.model == ProtoMessageModelBehaviour && [message.message.content.code isEqualToString:@"30001"]) {
        NSString *chatStatus = message.message.content.content;
        //channel  localid  时间戳
        NSDictionary *dict = @{
                               @"chatStatus":chatStatus,
                               @"time":@(message.message.timestamp)};
        [kNotification postNotificationName:kNotificationStatusChanged object:nil userInfo:dict];
        
    } else if (message.message.model == ProtoMessageModelChat) {
        SessonContentModel *model = [[SessonContentModel alloc] initWithProtoMessage:message isMyself:@0];
        if (message.message.msgType == ProtoMessageMessageTypeReceive) {
            
            if (self.openSound) {
                
                if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
                    [RemoteNotificationManage sendLocalNotification:model.contentText soundName:UILocalNotificationDefaultSoundName repeat:0];
                    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
                }
            }
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [[DatabaseCache shareInstance] addSessonContentInfo:model];
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                NSDictionary *parameterDic = [[NSDictionary alloc] initWithObjectsAndKeys:model,KMessageParameter, nil];
                
                [center postNotificationName:kNotificationReceiveNewMessage object:nil userInfo:parameterDic];
            });
            
        } else if(message.message.msgType == ProtoMessageMessageTypeSend) {
            
            //channel  localid  时间戳
            NSDictionary *dict = @{@"channel":message.broadcastId,
                                   @"key_id":message.message.id,
                                   @"localId":message.message.localId,
                                   @"time":@(message.message.timestamp)};
            [kNotification postNotificationName:kNotificationMessageIsReached object:nil userInfo:dict];
        }
    }
}

#pragma mark - MQtt Callback methods

- (void)session:(MQTTSession*)sender handleEvent:(MQTTSessionEvent)eventCode {
    
    self.isConnectingIMserver = NO;
    
    switch (eventCode) {
        case MQTTSessionEventConnected:
            
            NSLog(@"connected");
            [self subscribeTopic];
            _hasConnectToIMserver = YES;
            _connectTime = 0;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSDictionary *parameterDic = [[NSDictionary alloc] initWithObjectsAndKeys:@1,KMessageParameter, nil];
                [kNotification postNotificationName:kNotificationMqttStateChangedMessage object:nil userInfo:parameterDic];
            });
            
            break;
        case MQTTSessionEventConnectionRefused:
            
            NSLog(@"connection refused");
            _hasConnectToIMserver = NO;
            
            break;
        case MQTTSessionEventConnectionClosed:
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSDictionary *parameterDic = [[NSDictionary alloc] initWithObjectsAndKeys:@0,KMessageParameter, nil];
                [kNotification postNotificationName:kNotificationMqttStateChangedMessage object:nil userInfo:parameterDic];
            });

            NSLog(@"connection closed");
            _hasConnectToIMserver = NO;
            
            break;
        case MQTTSessionEventConnectionError:
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSDictionary *parameterDic = [[NSDictionary alloc] initWithObjectsAndKeys:@0,KMessageParameter, nil];
                [kNotification postNotificationName:kNotificationMqttStateChangedMessage object:nil userInfo:parameterDic];
            });

            NSLog(@"connection error,reconnecting...");
            _hasConnectToIMserver = NO;
            
            self.session.delegate = nil;
            self.session = nil;
            self.hasConnectToIMserver = NO;
            self.isConnectingIMserver = NO;
            
            if (_connectTime < 3) {
                
                [self reconnection];
                
            }
            
            _connectTime ++;
            
            break;
        case MQTTSessionEventProtocolError:
            
            NSLog(@"protocol error");
            _hasConnectToIMserver = NO;
            
            break;
        default:
            
            break;
    }
}

- (void)session:(MQTTSession*)sender
     newMessage:(NSData*)data
        onTopic:(NSString*)topic {

    @try {

        if ([topic isEqualToString:self.topic]) {
            ProtoMessage *message = [ProtoMessage parseFromData:data];
            [self handleResponseMessage:message];
            
        } else if ([topic isEqualToString:self.sysTopic]) {
            
            ProtoSystemMessage *message = [ProtoSystemMessage parseFromData:data];
            
            if ([message.code isEqualToString:@"10000"]) {
                
                if (_mainController.acceptOrdePromptView.isHidden) {
                    [_mainController WaitAcceptOrderAPI];
                }
                
            } else if([message.code isEqualToString:@"10001"]) {
                
                [_mainController hidePopverView];
                
            } else if([message.code isEqualToString:@"99999"]) {
                
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:KInvalidTokenErrorCode                                                                      forKey:NSLocalizedDescriptionKey];
                NSError *error = [NSError errorWithDomain:KCustomErrorDomain code:401 userInfo:userInfo];

                [NSError checkErrorFromServer:error response:nil];
                
            } else {
                
                [self handleResponseSystemMessage:message];
            }
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"ProtoMessage Exception:%@",exception);
    }
}

#pragma mark- WXApiDelegate

- (void)onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *response = (PayResp *)resp;
        switch (response.errCode) {
                
            case WXSuccess:
                
                break;
                
            default:
                
                break;
        }
    }
}

@end
