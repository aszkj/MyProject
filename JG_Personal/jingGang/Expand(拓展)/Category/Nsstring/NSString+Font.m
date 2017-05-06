//
//  NSString+Font.m
//  jingGang
//
//  Created by dengxf on 16/2/26.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "NSString+Font.h"

@implementation NSString (Font)
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    // 获得系统版本
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0) {
        return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    } else {
        return [self sizeWithFont:font constrainedToSize:maxSize];
    }
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}
@end
