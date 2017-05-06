//
//  NSString+Teshuzifu.m
//  Link
//
//  Created by zhupeng on 14-6-22.
//  Copyright (c) 2014年 51sole. All rights reserved.
//

#import "NSString+Teshuzifu.h"
#import "sys/utsname.h"

@implementation NSString (Additions)

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (CGSize)getSizeWithWidth:(CGFloat)width fontSize:(CGFloat)aSize
{
    UIFont *font = [UIFont systemFontOfSize:aSize];
    CGSize size = CGSizeZero;
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
    {
        NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
        size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    }
    else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        size = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];//ios7以上已经摒弃的这个方法
#pragma clang diagnostic pop
    }
    
    return size;
}

- (CGSize)getSizeWithWidth:(CGFloat)width font:(UIFont *)font
{
    CGSize size = CGSizeZero;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
    {
        NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
        size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    }
    else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        size = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];//ios7以上已经摒弃的这个方法
#pragma clang diagnostic pop
    }
    
    return size;
}

- (NSString *)numberValue {
    NSString *originalString = self;
    NSMutableString *strippedString = [NSMutableString
                                       stringWithCapacity:originalString.length];
    
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet
                               characterSetWithCharactersInString:@"0123456789"];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
            [strippedString appendString:buffer];
            
        } else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    return strippedString.copy;
}

- (BOOL)containsString:(NSString *)aString
{
	NSRange range = [self rangeOfString:aString];
	return range.location != NSNotFound;
}

+ (NSString *)timeIntervalSince1970
{
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
    NSString *mid = [NSString stringWithFormat:@"%lld",(unsigned long long)time];
    
    return mid;
}

- (NSString *)translateToStandardTime
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:confromTimesp];
    
    return currentDateStr;
}

+ (NSString*)deviceString
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone7,3"])    return @"iPhone 6 plus";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";

    return deviceString;
}

+ (NSString *)getUniqueStrByUUID
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef= CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *retStr = [NSString stringWithString:(__bridge NSString *)uuidStrRef];
    CFRelease(uuidStrRef);
    
    return retStr;
}

- (NSString *)castHourMinuteSecondeStrForTheTimeStr {
    
    const NSInteger yearMonthDayTimeStringLength = 10;
    if (self.length > yearMonthDayTimeStringLength) {
        return [self substringToIndex:yearMonthDayTimeStringLength];
    }
    return self;
    
}


//返回字符串所占用的尺寸.
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (BOOL)canDisplayOnOneLineWithFontSize:(CGFloat)fontSize onelineMaxWidth:(CGFloat)maxWidth{
    CGSize trueDisplaySize = [self sizeWithFont:[UIFont systemFontOfSize:fontSize] maxSize:CGSizeMake(1000, 1000)];
    return trueDisplaySize.width < maxWidth;
}

+ (NSString *)stringFromJsonDictionary:(NSDictionary *)dic
{
    NSData *contentData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *contentString = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    return contentString;
}

- (NSString*)telephoneWithReformat
{
    NSString *string = self;
    if ([self containsString:@"-"])
    {
        string = [self stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    if ([self containsString:@" "])
    {
        string = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    if ([self containsString:@"("])
    {
        string = [self stringByReplacingOccurrencesOfString:@"(" withString:@""];
    }
    
    if ([self containsString:@")"])
    {
        string = [self stringByReplacingOccurrencesOfString:@")" withString:@""];
    }
    
    return string;
}

- (NSArray *)jiexiFromJsonString:(NSString *)string
{
    NSString *jsonString = string;
    if (jsonString) {
        id json = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        if (json == nil) {
            return nil;
        }
        if ([json isKindOfClass:[NSArray class]]) {
            return json;
        }
        else{
            return nil;
        }
    }
    else
        return nil;
}

@end
