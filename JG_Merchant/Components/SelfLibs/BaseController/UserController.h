//
//  UserController.h
//  jingGang
//
//  Created by zhupeng on 15-9-1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.

#import "Controller.h"
//#import "CWDataModels.h"


@interface UserController : Controller

+ (UserController *)SObject;

#pragma mark 请求封装信息
-(void)addRequestParams:(NSDictionary *)info;
#pragma mark 取得请求封装信息
-(NSDictionary *)requestParams;

#pragma mark 创建用户文件夹
- (NSString *)createUserFiles;

#pragma mark 用户目录下图片文件夹
- (NSString *)userImagesDic;

#pragma mark 用户目录下音乐文件夹
- (NSString *)userAudiosDic;

#pragma mark 上传缓存文件夹
- (NSString *)userUploadCacheDic;

#pragma mark 用户目录下缓存文件夹
- (NSString *)userCacheDic;

#pragma mark 用户目录下缩略图文件夹
-(NSString *)userThumbnsDic;

- (NSString *)getCurrentUserId;

@end

@interface UserController ()

@property(nonatomic,assign)NSInteger tcpStatus;     //tcp 网络状态
@end

