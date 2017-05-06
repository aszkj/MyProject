//
//  AppDelegate.m
//  YilidiBuyer
//
//  Created by yld on 16/4/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "AppDelegate.h"
#import "DLMainTabBarController.h"
#import <Aspects/Aspects.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import "DLLoginVC.h"
#import "ShopCartGoodsManager.h"
#import "GuideViewController.h"
#import "ProjectRelativeKey.h"
#import "GlobleConst.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "WXinPayResponseModel.h"
#import "DLCacheManager.h"
#import "ProjectRelativeDefineNotification.h"
#import "AliPayResponseModel.h"
#import "ShopCartGoodsManager+goodsCache.h"
#import <TencentOpenAPI/TencentOAuth.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];

    [self _configureHookInfo];
    
    [self _configureKeyBoard];
    
    [self _configureLog];
    
    [self _configureThirdPlatForm];
    
    [self _entrance];
    
    
    return YES;
}



- (void)_configureThirdPlatForm {
    
    [WXApi registerApp:@"wxadf10b780467d1f7"];
//    [WXApi registerApp:@"wx4868b35061f87885"];
}

- (void)_entrance {
    
    BOOL isAppFirstLauched = [[kUserDefaults valueForKey:@"isAppFirstLauched"] boolValue];
    if (isAppFirstLauched) {
//        if (SESSIONID) {
            [self _enterMain];
//        }else {
//            [self _enterLogin];
//        }
    }else {
        [self _enterGuidePage];
    }
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
                                   DDLogVerbose(@"view did appear: %@",                                   [aspectInfo instance]);
                               } error:NULL];
#else
    
#endif

    
}

- (void)_enterLogin {
    DLLoginVC *loginVc = [[DLLoginVC alloc] init];
    loginVc.enterFromLoginOrLogout = YES;
    self.window.rootViewController = loginVc;
}

- (void)_enterMain {
    
    DLMainTabBarController *mainVC = [[DLMainTabBarController alloc] init];
//    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
    self.window.rootViewController = mainVC;
    
}

- (void)_enterGuidePage {
    //引导页面
    GuideViewController *guideVC = [[GuideViewController alloc] init];
    self.window.rootViewController = guideVC;
}

//获取用户UUID,即使卸载程序还会存在，只有退出当前账户才重新生成
- (void)_setUUID {
    
    NSMutableDictionary *getUUID = (NSMutableDictionary *)[CHKeychain load:DEVICEID_IN_KECHAIN];
    JLog(@"UUID%@",[getUUID objectForKey:DEVICEIDKEY]);
    if ([getUUID objectForKey:DEVICEIDKEY]==nil) {
        NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        NSMutableDictionary *setUUID = [NSMutableDictionary dictionary];
        [setUUID setObject:uuid forKey:DEVICEIDKEY];
        [CHKeychain save:DEVICEID_IN_KECHAIN data:setUUID];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    [[ShopCartGoodsManager sharedManager] doShopCartCache];
    [[DLCacheManager sharedManager] doCache];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}



- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    [self handleAliCallBackUrl:url];
    
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    [self handleAliCallBackUrl:url];
    [TencentOAuth HandleOpenURL:url];
    return [WXApi handleOpenURL:url delegate:self];
//    return YES;
}


- (void)handleAliCallBackUrl:(NSURL *)url {
    //跳转支付宝钱包进行支付，处理支付结果
    JLog(@"平台 url %@",url.absoluteString);
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        JLog(@"ali pay result = %@",resultDic);
        AliPayResponseModel *responseModel = [[AliPayResponseModel alloc] initWithDefaultDataDic:resultDic];
        [kNotification postNotificationName:KNotificationAliPayResult object:responseModel];
    }];
    
}



-(void)onResp:(BaseResp *)resp{
    
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *wxResp = (PayResp *)resp;
        WXinPayResponseModel *wxResponseModel = [[WXinPayResponseModel alloc] init];
        wxResponseModel.weixinResp = wxResp;
        [kNotification postNotificationName:KNotificationWXPayResult object:wxResponseModel];
    }
    if ([resp isKindOfClass:[SendMessageToWXResp class]]){
    
        NSString *message;
        if(resp.errCode == 0) {
            message = @"分享成功";
        }else{
            message = @"分享失败";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [alert show];
        
    }
    
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if (aresp.errCode == 0) { // 用户同意
            NSLog(@"errCode = %d", aresp.errCode);
            NSLog(@"code = %@", aresp.code);
            
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"wechatLogin" object:aresp.code];
            

//            // 获取access_token  code是一次性的，后台请求了，app再请求就会出错
//            //      格式：https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
//            NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", APP_ID, APP_SECRET, aresp.code];
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                NSURL *zoneUrl = [NSURL URLWithString:url];
//                NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
//                NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    if (data) {
//                        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                        _openid = [dic objectForKey:@"openid"]; // 初始化
//                        _access_token = [dic objectForKey:@"access_token"];
//                        NSLog(@"openid = %@", _openid);
//                        NSLog(@"access = %@", [dic objectForKey:@"access_token"]);
//                        NSLog(@"dic = %@", dic);
////                        [self getUserInfo]; // 获取用户信息
//                    }
//                });
//            });
        } else if (aresp.errCode == -2) {
            NSLog(@"用户取消登录");
        } else if (aresp.errCode == -4) {
            NSLog(@"用户拒绝登录");
        } else {
            NSLog(@"errCode = %d", aresp.errCode);
            NSLog(@"code = %@", aresp.code);
        }

    }
        
    
    
}


// 获取用户信息
- (void)getUserInfo {
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@", self.access_token, self.openid];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"openid = %@", [dic objectForKey:@"openid"]);
                NSLog(@"nickname = %@", [dic objectForKey:@"nickname"]);
                NSLog(@"sex = %@", [dic objectForKey:@"sex"]);
                NSLog(@"country = %@", [dic objectForKey:@"country"]);
                NSLog(@"province = %@", [dic objectForKey:@"province"]);
                NSLog(@"city = %@", [dic objectForKey:@"city"]);
                NSLog(@"headimgurl = %@", [dic objectForKey:@"headimgurl"]);
                NSLog(@"unionid = %@", [dic objectForKey:@"unionid"]);
                NSLog(@"privilege = %@", [dic objectForKey:@"privilege"]);
                
                
            }
        });
    });
}



- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[ShopCartGoodsManager sharedManager] doShopCartCache];
    [[DLCacheManager sharedManager] doCache];
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

@end
