//
//  JGMessageManager.m
//  jingGang
//
//  Created by 张康健 on 15/6/20.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "JGMessageManager.h"
#import "TMCache.h"

static JGMessageManager *_JGMessageManager = nil;
@interface JGMessageManager(){

    TMCache * _cache;

}

@end

@implementation JGMessageManager

+ (id)shareInstances
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _JGMessageManager = [[JGMessageManager alloc]init];
    });
    
    return _JGMessageManager;
}



- (id)init
{
    self = [super init];
    
    if (self) {
        
        //初始化消息信息
        [self _initMsg];
        
        //初始化消息接收通知
        [self _initMsgRecieveNotification];
        
    }
    return self;
}


#pragma mark ----------- private Method
-(void)_initMsg{

    _cache = [TMCache sharedCache];
    //先从缓存中初始化未读咨询消息
    NSMutableArray *cacheUnreadInfoMsg = [_cache objectForKey:UnreadInfo_cache_key];
    if (!cacheUnreadInfoMsg) {//说明没有缓存未读消息
        _unreadInfoMsgArr = [[NSMutableArray arrayWithCapacity:0] mutableCopy];
    }else{
        _unreadInfoMsgArr = [cacheUnreadInfoMsg mutableCopy];
    }
    _unreadInfoMsgCount = self.unreadInfoMsgArr.count;
    
    
    //先从缓存中初始化未读咨询消息
    NSMutableArray *cacheUnreadCustomMsg = [_cache objectForKey:UnreadCustomMsg_cache_key];
    if (!cacheUnreadCustomMsg) {//说明没有缓存未读消息
        _unreadCustomMsgArr = [[NSMutableArray arrayWithCapacity:0] mutableCopy];
    }else{
        _unreadCustomMsgArr = [cacheUnreadCustomMsg mutableCopy];
    }
    _unreadCustomMsgCount = self.unreadCustomMsgArr.count;
    
}//初始化消息




-(void)_initMsgRecieveNotification{
    
    //注册资讯信息通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoMsgReceiveNotify:) name:Info_Message_Notification object:nil];
    
    //注册自定义信息通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CustomMsgReceiveNotify:) name:Cutom_Message_Notification object:nil];

}//初始化接收消息的通知



#pragma mark ------------public Method
-(void)resetInfoMsgForMessageType:(RemotePushMessageType)messageType{

    if (messageType == Consult_Message_Type) {//咨询消息清空
        [_unreadInfoMsgArr removeAllObjects];
        self.unreadInfoMsgCount = 0;
        [_cache removeObjectForKey:UnreadInfo_cache_key];
    }else if (messageType == Custom_Message_Type){//自定义消息清空
        [_unreadCustomMsgArr removeAllObjects];
        self.unreadCustomMsgCount = 0;
        [_cache removeObjectForKey:UnreadCustomMsg_cache_key];
    }

}//重置资讯信息


-(void)saveUnreadInfoMsg {
    
    if (self.unreadInfoMsgCount > 0) {
        [_cache setObject:_unreadInfoMsgArr forKey:UnreadInfo_cache_key];
    }else{
        [_cache setObject:nil forKey:UnreadInfo_cache_key];
    }
    
}//保存未读信息



#pragma mark - 资讯接收消息通知响应函数
-(void)InfoMsgReceiveNotify:(NSNotification *)notification{
    
    NSDictionary *uerInfo = (NSDictionary *)notification.object;
    NSLog(@"infoMsgNotifyInfo------ : %@",uerInfo);
#pragma mark - warn 注意，这里点语法不能滥用，，不然会崩溃，，
    //推送过来的消息，加在未读消息数组中
    [_unreadInfoMsgArr addObject:uerInfo];
    self.unreadInfoMsgCount = _unreadInfoMsgArr.count;
//    NSLog(@"msgArr:%@",_unreadInfoMsgArr);
}


#pragma mark - 自定义消息通知响应函数
-(void)CustomMsgReceiveNotify:(NSNotification *)notification{
    
    NSDictionary *userInfo = (NSDictionary *)notification.object;
    
    NSLog(@"CustomMsgNotifyInfo------ : %@",userInfo);
#pragma mark - warn 注意，这里点语法不能滥用，，不然会崩溃，，
    //推送过来的消息，加在未读消息数组中
    [_unreadCustomMsgArr addObject:userInfo];
    self.unreadCustomMsgCount = _unreadCustomMsgArr.count;
//    NSLog(@"msgArr:%@",_unreadCustomMsgArr);
    
}


- (void)dealloc
{
    //移除监听者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Info_Message_Notification object:nil];
    //移除监听者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Cutom_Message_Notification object:nil];
}



@end
