//
//  CHKeychain.h
//  key
//
//  Created by gao wuhang on 13-1-9.
//  Copyright (c) 2013年 gao wuhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DEVICEID_IN_KECHAIN  @"DEVICEID_IN_KECHAIN"
#define DEVICEIDKEY          @"DEVICEIDKEY" 
@interface CHKeychain : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;

@end
