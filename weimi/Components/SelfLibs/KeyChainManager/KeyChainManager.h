//
//  KeyChainManager.h
//  BaiYing_Thinker
//
//  Created by ray on 16/1/14.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainManager : NSObject

+ (NSString *)getDeviceToken;
/**
 *  设置deviceToken，当已存在deviceToken时忽略
 */
+ (void)setDeviceToken:(NSString *)deviceToken;
+ (NSString *)getAPPID;
/**
 *  设置appid，当已存在appid时忽略
 */
+ (void)setAPPID:(NSString *)appid;

@end
