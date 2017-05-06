//
//  NSString+BlankString.m
//  jingGang
//
//  Created by zhupeng on 15-9-1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.

#import "NSString+BlankString.h"

@implementation NSString (BlankString)

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (NSString *)stringDiseposeNullWithStr:(NSString *)str
{
    if ([str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"]) {
        str = @"";
    }
    return str;
}


+ (NSString *)decoratedString:(NSString *)fromString {
    return [[self class] decoratedString:fromString insertString:@"," everyRange:3];
}

+ (NSString *)decoratedString:(NSString *)fromString insertString:(NSString *)decorateString everyRange:(NSUInteger)range
{
    if (!fromString.length > 0) return @"0";
    NSRange pointRange = [fromString rangeOfString:@"."];
    NSMutableString *muStr;
    NSString *floatString = @"";
    if (pointRange.length > 0) {
        muStr = [[NSMutableString alloc] initWithString:[fromString substringToIndex:pointRange.location]];
        floatString = [fromString substringFromIndex:pointRange.location];
        if (floatString.length > range) {
            floatString = [floatString substringToIndex:range];
        }
    } else {
        muStr = [[NSMutableString alloc] initWithString:fromString];
    }
    
    NSUInteger length = muStr.length;
    for (int i = 1; i <= length/range; i++) {
        [muStr insertString:decorateString atIndex:length-i*range];
    }
    if ([[muStr substringToIndex:1] isEqualToString:decorateString]) {
        [muStr deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    return [muStr.copy stringByAppendingString:floatString];
}

//格式化日期
+ (NSString *)getTime:(NSString *)preTime {
    NSString *time = @"";
    if (!IsEmpty(preTime)) {
        time = [preTime substringToIndex:((NSRange)[preTime rangeOfString:@":" options:NSBackwardsSearch]).location];
    }
    return time;
}

@end
