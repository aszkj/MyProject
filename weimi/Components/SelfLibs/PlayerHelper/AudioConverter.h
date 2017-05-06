//
//  AudioConverter.h
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/29.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioConverter : NSObject

+ (NSData *)convertToMp3OfPath:(NSString *)filePath;

@end
