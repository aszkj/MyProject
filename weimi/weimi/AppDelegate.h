//
//  AppDelegate.h
//  weimi
//
//  Created by 鹏 朱 on 16/1/18.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQTTSession.h"
#import "ChatViewController.h"

@class CLLocation;
@class Reachability;
@class ProtoMessage;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) ChatViewController *mainController;
@property (nonatomic, strong) MQTTSession *session;
@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) BOOL tabBarHidden;
@property (strong, nonatomic) NSString *currentUser;
@property (strong, nonatomic) NSString *deviceToken;
@property (strong, nonatomic) NSString *clientId;
@property(nonatomic, strong) NSString *topic;
@property(nonatomic, strong) NSString *sysTopic;
@property(nonatomic, strong) NSString *messageId;
@property (nonatomic) BOOL hasConnectToIMserver;          //是否连接到IM服务器
@property (nonatomic) BOOL isConnectingIMserver;          //是否正在连接到IM服务器
@property (nonatomic, strong) Reachability *reach;
@property (nonatomic) BOOL networkable;    //是否可以联网
@property (nonatomic) BOOL openSound;       //是否开启声音提示

@property (nonatomic) NSString *currentChannel;//当前界面的channel

- (void)userExit;


//初始化mqt服务器
- (void)initIMServerInfo;
- (void)initApiClient;
- (void)connectToServer;
- (void)disConnect;
// 上传通讯录
- (void)uploadPhonesInfo;
// 上传地理位置信息
- (void)uploadLocationInfo;
//上传apnToken
- (void)uploadApnToken;
//发消息
- (void)sendMessage:(ProtoMessage *)message;

@end

