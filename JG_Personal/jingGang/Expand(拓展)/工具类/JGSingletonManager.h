//
//  JGSingletonManager.h
//  jingGang
//
//  Created by dengxf on 16/1/25.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGSingletonManager : NSObject

+ (JGSingletonManager *)sharedManager;

- (id)sharedInstanceFor:(Class)aClass;
- (id)sharedInstanceFor:(Class)aClass category:(NSString *)key;

- (void)destroySharedInstanceFor:(Class)aClass;
- (void)destroySharedInstanceFor:(Class)aClass category:(NSString *)key;

@end
