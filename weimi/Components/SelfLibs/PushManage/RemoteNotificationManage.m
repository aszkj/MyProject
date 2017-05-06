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
        UIUserNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound |
        UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else
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

@end
