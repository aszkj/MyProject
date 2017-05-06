//
//  NSString+BlankString.h
//  jingGang
//
//  Created by zhupeng on 15-9-1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.

#import <Foundation/Foundation.h>

@interface NSString (BlankString)

+ (BOOL) isBlankString:(NSString *)string;
/**
 *  获取经过修饰的表示金钱的字符串
 *
 *  @param fromString 原始金钱的字符,例如1212441
 *
 *  @return 返回2‘123'123格式的金钱数额
 */
+ (NSString *)decoratedString:(NSString *)fromString;
@end
