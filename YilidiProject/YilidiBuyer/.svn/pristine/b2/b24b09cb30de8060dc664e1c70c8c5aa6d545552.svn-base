//
//  PushMessageManager.m
//  YilidiBuyer
//
//  Created by mm on 17/4/1.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "PushMessageManager.h"
#import "CNotificationManager.h"
#import "ProjectRelativeDefineNotification.h"
#import "GlobleConst.h"
#import "DLLoginVC.h"
#import "DLMainTabBarController.h"
#import "EBMuteDetector.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

static PushMessageManager *_pushMessageManager = nil;

@interface PushMessageManager ()

@property (nonatomic,assign)BOOL hasMessageToJump;
@property (nonatomic,strong)UIViewController *messageNeedToJumpPageVC;
@property (nonatomic,strong)UIViewController *currentVC;
@property (nonatomic,copy) NSDictionary *appLaunchPushMessage;
@property (nonatomic,getter=isMessagePageRoutedByMessage) BOOL messagePageRoutedByMessage;

@end

@implementation PushMessageManager

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _pushMessageManager = [[PushMessageManager alloc] init];
        
    });
    return _pushMessageManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}


- (void)handleAppLaunchMessage:(NSDictionary *)appLaunchMessage{
    self.appLaunchPushMessage = appLaunchMessage[UIApplicationLaunchOptionsRemoteNotificationKey][@"aps"];
}

- (void)handleAppLaunchMessageJumpLogic {
    if (self.appLaunchPushMessage) {
        [self userClickToJumpForMessage:[[PushMessageModel alloc] initWithDefaultDataDic:self.appLaunchPushMessage]];
    }
}

- (void)handlePushMessage:(PushMessageModel *)messageModel {
    if (self.appLaunchPushMessage) {
        return;
    }
    if (messageModel.isOffLineMessage) {
        [self handleOfflinePushMessage:messageModel];
    }else {
        [self handleOnlinePushMessage:messageModel];
    }
}

#pragma mark - 在线消息处理
- (void)handleOnlinePushMessage:(PushMessageModel *)messageModel {
    [CNotificationManager showMessage:messageModel withOptions:@{CN_TEXT_COLOR_KEY:[UIColor yellowColor],CN_BACKGROUND_COLOR_KEY:[UIColor redColor]} completeBlock:^(BOOL isUserClickedToComplete) {
        if (isUserClickedToComplete) {
            [self userClickToJumpForMessage:messageModel];
        }else {
            [self postPushNotificationForMessage:messageModel];
        }
    }];
    
    [self playOnlineMesssageSound];
    
}

- (void)playOnlineMesssageSound {
    int soundID = 1312;
    [[EBMuteDetector sharedDetecotr] detectComplete:^(BOOL isMute) {
        if (isMute) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }else{
            AudioServicesPlaySystemSound(soundID);
        }
    }];
}

#pragma mark - 离线消息处理
- (void)handleOfflinePushMessage:(PushMessageModel *)messageModel {
    if (messageModel.userHasClickedThisMessage) {
        [self handleNeedToJumpOfflinePushMessage:messageModel];
    }else {
        [self handleNeedNotToJumpOfflinePushMessage:messageModel];
    }
}

- (void)handleNeedNotToJumpOfflinePushMessage:(PushMessageModel *)messageModel {
    
    [self postPushNotificationForMessage:messageModel];
}

- (void)handleNeedToJumpOfflinePushMessage:(PushMessageModel *)messageModel {
    [self userClickToJumpForMessage:messageModel];
}

#pragma mark - 发送消息通知
- (void)postPushNotificationForMessage:(PushMessageModel *)messageModel{
    [kNotification postNotificationName:KNotificationHasRecievedPushNotification object:messageModel];
}

#pragma mark - 消息跳转逻辑
- (void)userClickToJumpForMessage:(PushMessageModel *)messageModel{
    //消息要跳到那个页面
    self.messageNeedToJumpPageVC = [self getNeedtoJumpPageForMessage:messageModel];
    
    //判断当前页是否就在目的消息页
    if ([self currentPageExactlyTheMessageDestionationPage]) {//不跳
        [self postPushNotificationForMessage:messageModel];
    }else {//跳
        if (self.hasMessageToJump) {
            return;
        }
        self.hasMessageToJump = YES;
        [self excuteJumpLogicForMessage:messageModel];
        //不管跳到那个页面，当前页面变化了，重置当前页
    }
}

- (void)excuteJumpLogicForMessage:(PushMessageModel *)messageModel {
    if (UserIsLogin) {
        [self jumpToMessageDestinationPage];
    }else {
        if (![self currentPageIsInLoginPage]) {
            [self jumpToLoginPage];
        }
    }
}

- (void)jumpToMessageDestinationPage {
    [self.currentVC.navigationController pushViewController:self.messageNeedToJumpPageVC animated:YES];
    [self clearMessageNeedToJump];
    self.messagePageRoutedByMessage = YES;
}

- (void)jumpToLoginPage {
    DLLoginVC *loginVC = [[DLLoginVC alloc] init];
    [self.currentVC.navigationController pushViewController:loginVC animated:YES];
}

- (BOOL)hasMessageNeedToJump {
    return self.hasMessageToJump;
}

- (void)clearMessageNeedToJump {
    self.hasMessageToJump = NO;
    if (self.appLaunchPushMessage) {
        self.appLaunchPushMessage = nil;
    }
}

- (BOOL)currentPageExactlyTheMessageDestionationPage {
    return [self.currentVC isKindOfClass:[self.messageNeedToJumpPageVC class]];
}

- (BOOL)currentPageIsInLoginPage {
    return [self.currentVC isKindOfClass:[DLLoginVC class]];
}


- (UIViewController *)getNeedtoJumpPageForMessage:(PushMessageModel *)messageModel {
    NSString *needToJumpPageClassName = nil;
    switch (messageModel.pushMessageType) {
            case PushMessage_Tickect:
            needToJumpPageClassName = @"DLPrivilegeMessageVC";
            break;
        case PushMessage_Refund:
            needToJumpPageClassName = @"DLRefundMessageVC";
            break;
        case PushMessage_Activity:
            needToJumpPageClassName = @"DLActivityMessageVC";
            break;
        default:
            break;
    }
    
    return [[NSClassFromString(needToJumpPageClassName) alloc] init];
}

- (void)messagePageBack {
    if (self.isMessagePageRoutedByMessage) {//由消息跳过来的
        if (self.isMessageJumpThroughLogin) {//经过了登陆，返回首页
            [self enterMain];
        }else {
            [self messagePageNormalBack];
        }
        self.messagePageRoutedByMessage = NO;
        self.messageJumpThroughLogin = NO;
    }else {
        [self messagePageNormalBack];
    }
}

- (void)messagePageNormalBack {
    [self.currentVC.navigationController popViewControllerAnimated:YES];
}

- (void)enterMain {
    DLMainTabBarController *mainVC = [[DLMainTabBarController alloc]init];
    [mainVC setTabIndex:0];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
}

- (UIViewController *)currentVC {
    return [Util currentViewController];
}

- (BOOL)hasLauchRemotePushMessage {
    
    return self.appLaunchPushMessage != nil;
}


@end
