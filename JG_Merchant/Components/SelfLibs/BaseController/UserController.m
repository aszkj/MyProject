//
//  UserController.m
//  jingGang
//
//  Created by zhupeng on 15-9-1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.

#import "UserController.h"
//#import "CWUserInfoTabel.h"
//#import "CWUserDB.h"

static UserController *_AppController = nil;
#define NET_PARAM_DEVICETOKEN        @"deviceToken"


@interface UserController(){
    
}

@end

@implementation UserController

+ (UserController *)SObject {
	@synchronized(self) {
        if (_AppController == nil) {
            _AppController = [[[self class] alloc] init];
        }
        return _AppController;
    }
}

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark 是否登陆
-(BOOL)isLogined
{
    return YES;
}

#pragma mark 用户令牌
- (NSString *)userDeviceToken{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *niceName = [defaults objectForKey:[self joinKeyWithName:NET_PARAM_DEVICETOKEN]];
    if (niceName) {
        return niceName;
    }
    return @"";
}
#pragma mark 用户保存令牌
- (void)setUserDeviceToken:(NSString*)deviceToken{
    NSDictionary *dict = [NSDictionary dictionaryWithObject:deviceToken forKey:NET_PARAM_DEVICETOKEN];
    [self doUserDatasToPlist:dict];
}

#pragma mark 请求封装信息
-(void)addRequestParams:(NSDictionary *)info
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:info forKey:[self joinKeyWithName:@"REQUESTURL"]];
    [defaults synchronize];
}
-(NSDictionary *)requestParams
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dis = [defaults objectForKey:[self joinKeyWithName:@"REQUESTURL"]];
    return dis;
}
#pragma mark 创建用户文件夹
- (NSString *)createUserFiles {
    NSString *root = [self userRootPath];
    if (root && [root length]>0) {
        NSString *path = [NSString stringWithFormat:@"%@/%@",root,[NSString stringWithFormat:@"%@.db",[self getCurrentUserId]]];
        NSFileManager *fp = [NSFileManager defaultManager];
        if (![fp fileExistsAtPath:path]) {
            [fp createDirectoryAtPath:path
          withIntermediateDirectories:YES
                           attributes:nil
                                error:nil];
        }
        return path;
    }
    return nil;
}

#pragma mark 取得当前用户ID
- (NSString *)getCurrentUserId{
    return @"";
}
- (NSString *)createUserDir:(NSString*)dir{
    NSString *root = [self userRootPath];
    if (root && [root length]>0) {
        NSString *path = [NSString stringWithFormat:@"%@/%@/%@",root,[NSString stringWithFormat:@"%@.db",[self getCurrentUserId]],dir];
        NSFileManager *fp = [NSFileManager defaultManager];
        if (![fp fileExistsAtPath:path]) {
            [fp createDirectoryAtPath:path
          withIntermediateDirectories:YES
                           attributes:nil
                                error:nil];
        }
        return path;
    }
    return nil;
}

#pragma mark 用户目录下图片文件夹
- (NSString *)userImagesDic {
    return [self createUserDir:@"images"];
}

- (NSString *)userAudiosDic
{
    return [self createUserDir:@"audios"];
}

- (NSString *)userUploadCacheDic
{
    return [self createUserDir:@"upload_cache"];
}

#pragma mark 用户目录下缓存文件夹
- (NSString *)userCacheDic{
    NSString *root = [self userRootPath];
    if (root && [root length]>0) {
        NSString *path = [NSString stringWithFormat:@"%@/%@/%@",root,[NSString stringWithFormat:@"%@.db",[self getCurrentUserId]],@"cache"];
        NSFileManager *fp = [NSFileManager defaultManager];
        if (![fp fileExistsAtPath:path]) {
            [fp createDirectoryAtPath:path
          withIntermediateDirectories:YES
                           attributes:nil
                                error:nil];
        }
        return path;
    }
    return nil;
}
#pragma mark 用户目录下缩略图文件夹
-(NSString *)userThumbnsDic
{
    NSString *root = [self userRootPath];
    if (root && [root length]>0) {
        NSString *path = [NSString stringWithFormat:@"%@/%@/%@",root,[NSString stringWithFormat:@"%@.db",[self getCurrentUserId]],@"thumbns"];
        NSFileManager *fp = [NSFileManager defaultManager];
        if (![fp fileExistsAtPath:path]) {
            [fp createDirectoryAtPath:path
          withIntermediateDirectories:YES
                           attributes:nil
                                error:nil];
        }
        return path;
    }
    return nil;
}


@end