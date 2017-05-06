//
//  RemoteNotificationManage.h
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/20.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RemoteNotificationManageDelegate <NSObject>

@optional
-(void)remoteNotificationManageDelegateAction:(NSObject *)pushMessage;

@end

@interface RemoteNotificationManage : NSObject{
    NSString            *_deviceToken;
    BOOL                isOpen;
}
@property (nonatomic, assign)id<RemoteNotificationManageDelegate> delegate;
@property (nonatomic, copy) NSString *deviceToken;

// 获得推送管理对象
+ (RemoteNotificationManage*) sharedRemoteNotificationManage;

// 注册推送通知
- (void) registerNotification;

// 注册失败
- (void) failToRegisterForRemoteNotificationsWithError:(NSError*)error;

// 注册成功
- (void) registerForRemoteNotificationsWithDeviceToken:(NSString*)deviceToken;

// 接收到远程通知
- (void) receiveRemoteNotification:(NSDictionary *)userInfo;

+ (UILocalNotification *)sendLocalNotification:(NSString *)alertBody soundName:(NSString *)soundName repeat: (NSCalendarUnit)repeatInterval;

@end
