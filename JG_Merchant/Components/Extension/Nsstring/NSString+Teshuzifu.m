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

- (CGSize)getSizeWithWidth:(CGFloat)width fontSize:(CGFloat)aSize
{
    UIFont *font = [UIFont systemFontOfSize:aSize];
    CGSize size;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
    {
        NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
        size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    }
    else{
        size = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];//ios7以上已经摒弃的这个方法
    }
    
    return size;
}

- (CGSize)getSizeWithWidth:(CGFloat)width font:(UIFont *)font
{
    CGSize size;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
    {
        NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
        size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    }
    else{
        size = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];//ios7以上已经摒弃的这个方法
    }
    
    return size;
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

+ (NSString *)stringFromJsonDictionary:(NSDictionary *)dic
{
    NSData *contentData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *contentString = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    return contentString;
}

@end
