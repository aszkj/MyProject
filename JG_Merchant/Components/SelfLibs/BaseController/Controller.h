//
//  Controller.h
//  jingGang
//
//  Created by zhupeng on 15-9-1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.

#import "Controller.h"
#import "Share.h"

@interface Controller : Share

+ (Controller *)SObject;



-(id)AppDelegate;

#pragma mark 保存标识
- (NSString *)joinKeyWithName:(NSString *)name;
- (BOOL)doUserDatasToPlist:(NSDictionary*)datas;

#pragma mark 用户目录
- (NSString *)userRootPath;

#pragma mark 检查当前网络连接是否正常
-(BOOL)connectedToNetWork;
#pragma mark 检查网络连接类型
-(int)getLinkNetTypeConnnection;

#pragma mark 判断程序是否第一次启动
-(NSString *)CWFirstStart;
#pragma mark 程序第一次启动
-(void)addCWFirstStart;

@end
