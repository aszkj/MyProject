//
//  NSString+Teshuzifu.h
//  Link
//
//  Created by zhupeng on 14-6-22.
//  Copyright (c) 2014年 51sole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

/**
 Returns the size of the string if it were rendered with the specified constraints.
 
 @param font          The font to use for computing the string size.
 
 @param size          The maximum acceptable size for the string. This value is
 used to calculate where line breaks and wrapping would occur.
 
 @param lineBreakMode The line break options for computing the size of the string.
 For a list of possible values, see NSLineBreakMode.
 
 @return              The width and height of the resulting string's bounding box.
 These values may be rounded up to the nearest whole number.
 */
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;
/**
 Try to parse this string, remove all but numbers from NSString and returns an `NSString`.
 @return Returns an `NSString` if parse succeed, or nil if an error occurs.
 */
- (NSString *)numberValue;



- (CGSize)getSizeWithWidth:(CGFloat)width fontSize:(CGFloat)size;
- (CGSize)getSizeWithWidth:(CGFloat)width font:(UIFont *)font;
- (BOOL)containsString:(NSString *)aString;

+ (NSString *)timeIntervalSince1970;
- (NSString *)translateToStandardTime;
- (NSString*)telephoneWithReformat;

+ (NSString*)deviceString;
+ (NSString *)getUniqueStrByUUID;

+ (NSString *)stringFromJsonDictionary:(NSDictionary *)dic;
- (NSArray *)jiexiFromJsonString:(NSString *)string;

@end
