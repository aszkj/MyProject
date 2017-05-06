//
//  Controller.m
//  jingGang
//
//  Created by zhupeng on 15-9-1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.

#import "Controller.h"
#import "AppDelegate.h"
#import "Reachability.h"

static Controller *_AppController = nil;
@implementation Controller


+ (Controller *)SObject {
	@synchronized(self) {
        if (_AppController == nil) {
            _AppController = [[[self class] alloc] init];
        }
        return _AppController;
    }
}




-(id)AppDelegate
{
    AppDelegate * delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return delegate.navController;
}

- (BOOL)doUserDatasToPlist:(NSDictionary*)datas {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    for (NSString *key in [datas allKeys]) {
        [defaults setValue:[datas valueForKey:key]
                    forKey:[self joinKeyWithName:key]];
        
    }
    [defaults synchronize];
    return YES;
}

- (NSString *)joinKeyWithName:(NSString *)name {
    return [NSString stringWithFormat:@"CW#%@",name];
}

#pragma mark 用户目录
- (NSString *)userRootPath {
    NSString *docs = [NSHomeDirectory()   stringByAppendingPathComponent:@"Documents"];
    NSString *name = @"0";
    if (name && [name length]>0) {
        NSString *path = [NSString stringWithFormat:@"%@",docs];
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
        NSString *path = [NSString stringWithFormat:@"%@/%@",root,@"thumbns"];
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



#pragma mark 检查当前网络连接是否正常
-(BOOL)connectedToNetWork
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}
#pragma mark 检查网络连接类型
-(int)getLinkNetTypeConnnection{
    int m_LinkType = 0;
    if ([self connectedToNetWork]) {
        Reachability  *_hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
        switch ([_hostReach currentReachabilityStatus]) {
            case NotReachable:
                m_LinkType = 0;
                break;
            case ReachableViaWiFi:
                m_LinkType = 2;
                break;
            case kReachableViaWWAN:
                m_LinkType = 1;
                break;
            default:
                break;
        }
    }else {
        m_LinkType = 0;
    }
    return m_LinkType;
}

#pragma mark 判断程序是否第一次启动
-(NSString *)CWFirstStart {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:[self joinKeyWithName:@"programFisit"]];
}

#pragma mark 程序第一次启动
-(void)addCWFirstStart {
    [self doUserDatasToPlist:[NSDictionary dictionaryWithObjectsAndKeys:@"programFisit",@"programFisit",nil]];
}

@end
