//
//  RemoteNotificationManage.m
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/20.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "RemoteNotificationManage.h"

static RemoteNotificationManage *static_remoteNotificationManage = nil;

@implementation RemoteNotificationManage
@synthesize deviceToken = _deviceToken;
@synthesize delegate;

+ (RemoteNotificationManage*) sharedRemoteNotificationManage
{
    @synchronized(self){
        if ( nil == static_remoteNotificationManage ) {
            static_remoteNotificationManage = [[RemoteNotificationManage alloc] init];
        }
    }
    return static_remoteNotificationManage;
}

- (void)registerNotification
{
    
#if SUPPORT_IOS8
    if (iOS8) {
        UIUserNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else
#endif
    {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
}

- (void) failToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
    
    // 从本地获取deviceToken
//    self.deviceToken = [MemberShare sharedMemberManage].deviceToken;
    
}

- (void)registerForRemoteNotificationsWithDeviceToken:(NSString*)deviceToken
{
    
    // 保存当前deviceToken
    self.deviceToken = deviceToken;
    
//    // 从本地获取deviceToken
//    NSString *oldDeviceToken = [MemberShare sharedMemberManage].deviceToken;
//    
//    // 如果之前都没有保存deviceToken，则将其发送到服务器上注册
//    if ( oldDeviceToken == nil || [oldDeviceToken length] == 0 || ![oldDeviceToken isEqualToString:newToken] ) {
//        
//        // 将当前deviceToken写入到本地
//        [[MemberShare sharedMemberManage] setDeviceToken:newToken];
//    }
    
}

- (void) receiveRemoteNotification:(NSDictionary *)userInfo
{

}

+ (UILocalNotification *)sendLocalNotification:(NSString *)alertBody soundName:(NSString *)soundName repeat: (NSCalendarUnit)repeatInterval
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置通知的提醒时间
    NSDate *currentDate   = [NSDate date];
    notification.timeZone = [NSTimeZone defaultTimeZone]; // 使用本地时区
    notification.fireDate = [currentDate dateByAddingTimeInterval:0.1];
    
    // 设置重复间隔
    notification.repeatInterval = repeatInterval;
    // 设置提醒的文字内容
    notification.alertBody = alertBody;
    // 通知提示音 使用默认的
    notification.soundName = soundName;
    
    // 将通知添加到系统中
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    return notification;
}


@end
