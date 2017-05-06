//
//  utility.h
//  jingGang
//
//  Created by wangying on 15/6/15.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface utility : NSObject
+(void)FaviousRequest:(NSString *)circle typte:(NSString *)type;
+(void)CancleFaviousRequest:(NSString *)circle;
+(void)ZanRequest:(NSString *)circle;
+(void)CancleZan:(NSString *)circle;
+(id)FollowRequest:(NSString *)num;

@end
