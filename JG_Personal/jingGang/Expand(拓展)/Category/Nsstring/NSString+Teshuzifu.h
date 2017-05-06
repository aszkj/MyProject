//
//  NSString+Teshuzifu.h
//  Link
//
//  Created by zhupeng on 14-6-22.
//  Copyright (c) 2014年 51sole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

- (CGSize)getSizeWithWidth:(CGFloat)width fontSize:(CGFloat)size;
- (CGSize)getSizeWithWidth:(CGFloat)width font:(UIFont *)font;
- (BOOL)containsString:(NSString *)aString;

+ (NSString *)timeIntervalSince1970;
- (NSString *)translateToStandardTime;

+ (NSString*)deviceString;
+ (NSString *)getUniqueStrByUUID;

+ (NSString *)stringFromJsonDictionary:(NSDictionary *)dic;

@end
