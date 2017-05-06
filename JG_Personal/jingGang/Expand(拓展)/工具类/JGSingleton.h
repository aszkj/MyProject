//
//  JGSingleton.h
//  jingGang
//
//  Created by dengxf on 16/1/25.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGSingleton : NSObject

+ (instancetype)sharedInstance;

+ (void)destorySharedInstance;

@end
