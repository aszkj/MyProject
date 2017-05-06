//
//  JGMessageManager.h
//  jingGang
//
//  Created by 张康健 on 15/6/20.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    Consult_Message_Type, //咨询消息
    Custom_Message_Type,  //自定义消息
}RemotePushMessageType;

//资讯消息通知
#define Info_Message_Notification @"Info_Message_Notification"

//自定义消息的通知
#define Cutom_Message_Notification @"Cutom_Message_Notification"

//资讯未读消息缓存key
#define UnreadInfo_cache_key @"UnreadInfo_cache_key"

//自定义未读消息缓存key
#define UnreadCustomMsg_cache_key @"UnreadCustomMsg_cache_key"


@interface JGMessageManager : NSObject

//信息管理单例
+ (id)shareInstances;

//当前未读资讯消息数
@property (nonatomic,assign)NSInteger unreadInfoMsgCount;

//当前未读自定义消息数
@property (nonatomic,assign)NSInteger unreadCustomMsgCount;

//当前未读资讯信息数组
@property (nonatomic,copy)NSMutableArray *unreadInfoMsgArr;

//当前未读自定义信息数组
@property (nonatomic,copy)NSMutableArray *unreadCustomMsgArr;


//重置资讯信息，即清空
-(void)resetInfoMsgForMessageType:(RemotePushMessageType)messageType;

//保存未读资讯信息,防止应用退出，还有未读消息
-(void)saveUnreadInfoMsg;


@end
