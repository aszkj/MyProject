//
//  PushMessageManager.h
//  YilidiBuyer
//
//  Created by mm on 17/4/1.
//  Copyright © 2017年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PushMessageModel.h"


@interface PushMessageManager : NSObject

+ (instancetype)sharedManager;

/**
 处理app启动时的消息
 */
- (void)handleAppLaunchMessage:(NSDictionary *)appLaunchMessage;

/**
 启动时有没有推送消息
 */
- (BOOL)hasLauchRemotePushMessage;
/**
 app启动若有推送消息，处理
 */
- (void)handleAppLaunchMessageJumpLogic;

/**
 处理推送消息统一接口，只处理app启动后的消息，不包括app刚启动时的消息
 */
- (void)handlePushMessage:(PushMessageModel *)messageModel;

/**
 是否有需要跳转的推送消息
 */
- (BOOL)hasMessageNeedToJump;

/**
 消息跳转是否经过登陆
 */
@property (nonatomic,getter=isMessageJumpThroughLogin) BOOL messageJumpThroughLogin;

/**
 跳转到目的消息页
 */
- (void)jumpToMessageDestinationPage;

/**
 消息页面返回
 */
- (void)messagePageBack;



@end
