//
//  NSString+InputView.m
//  BBAsk
//
//  Created by nolan on 14-7-11.
//  Copyright (c) 2014年 nolan.inc. All rights reserved.
//

#import "NSString+Utility.h"
#import <commoncrypto/CommonDigest.h>

@implementation NSString (Utility)

- (NSString *)xf_stringByTrimingWhitespaceOrNewlineCharacter
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)xf_stringByTrimingAllWhitespaces
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSUInteger)xf_numberOfLines
{
    return [[self componentsSeparatedByString:@"\n"] count] + 1;
}

- (BOOL)xf_isPureInt
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    scan.charactersToBeSkipped = nil;
    int val;
    return ([scan scanInt:&val] && [scan isAtEnd]);
}

- (BOOL)xf_isPureFloat
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    scan.charactersToBeSkipped = nil;
    float val;
    return ([scan scanFloat:&val] && [scan isAtEnd]);
}

- (NSString *)xf_readableDecimalNumber
{
    // 不是一个合法的数字字符串，则直接返回自身
    if (!self.length || ![self xf_isPureFloat]) {
        return self;
    }
    
    if (self.intValue <= 999 && self.intValue >= -999) {
        return [self xf_tidyReadableNumber];
    }
    
    NSString *tidyString = [self xf_tidyReadableNumber];
    
    NSArray *array = [tidyString componentsSeparatedByString:@"."];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    // 若针对 .5 这样的输入，整数部分length为0，则整数部分设置为"0"
    NSString *integralPart = [array xf_safeObjectAtIndex:0];
    // 大数处理
    NSNumber *number = [numberFormatter numberFromString:integralPart];
    NSString *display = [NSNumberFormatter localizedStringFromNumber:number
                                                         numberStyle:NSNumberFormatterDecimalStyle];
    
    NSString *floatNumber = [array xf_safeObjectAtIndex:1];
    NSString *conveniencedString = array.count > 1 ? [NSString stringWithFormat:@"%@.%@", display, floatNumber] : display;
    
    return conveniencedString;
}

- (NSString *)xf_convertReadableToNumberString
{
    NSArray *array = [self componentsSeparatedByString:@","];
    
    NSMutableString *numberString = [NSMutableString string];
    
    for (int i = 0; i < array.count; i++) {
        [numberString appendFormat:@"%@", [array xf_safeObjectAtIndex:i]];
    }
    
    return [NSString stringWithString:numberString];
}

- (NSString *)xf_tidyReadableNumber
{
    // 不是一个合法的数字字符串，则直接返回自身
    
    if (!self.length || ![self xf_isPureFloat]) {
        return self;
    }
    
    NSArray *array = [self componentsSeparatedByString:@"."];
    
    if (!array) {
        return nil;
    }
    
    NSMutableString *numberString = [NSMutableString string];
    // 若针对 .5 这样的输入，整数部分length为0，则整数部分设置为"0"
    NSString *integralPart = [array firstObject];
    if (integralPart.length == 0) {
        integralPart = @"0";
    }
    
    [numberString appendFormat:@"%@", integralPart];
    
    NSString *suffix = [array xf_safeObjectAtIndex:1];
    if (suffix.length) {
        char first = [suffix xf_safeCharacterAtIndex:0];
        char second = [suffix xf_safeCharacterAtIndex:1];
        if (second && second != '0') {
            [numberString appendFormat:@".%c%c", first, second];
        } else if (first && first != '0') {
            [numberString appendFormat:@".%c0", first];
        }
    }
    
    return [NSString stringWithString:numberString];
}

- (NSString *)xf_tidyReadableRateNumber
{
    // 不是一个合法的数字字符串，则直接返回自身
    
    if (!self.length || ![self xf_isPureFloat]) {
        return self;
    }
    
    NSArray *array = [self componentsSeparatedByString:@"."];
    
    if (!array) {
        return nil;
    }
    
    NSMutableString *numberString = [NSMutableString string];
    // 若针对 .5 这样的输入，整数部分length为0，则整数部分设置为"0"
    NSString *integralPart = [array firstObject];
    if (integralPart.length == 0) {
        integralPart = @"0";
    }
    
    [numberString appendFormat:@"%@", integralPart];
    
    NSString *suffix = [array xf_safeObjectAtIndex:1];
    if (suffix.length) {
        char first = [suffix xf_safeCharacterAtIndex:0];
        if (first && first != '0') {
            [numberString appendFormat:@".%c", first];
        }
    }
    
    return [NSString stringWithString:numberString];
}

- (BOOL) xf_isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//手机号码验证
- (BOOL) xf_isValidatePhoneNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,176,185,186
     * 电信：133,1349,153,180,181,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,176,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|76|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,181,189
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES) || ([regextestcm evaluateWithObject:self] == YES) || ([regextestct evaluateWithObject:self] == YES) || ([regextestcu evaluateWithObject:self] == YES)) {
        return YES;
    } else {
        return NO;
    }
}

//用户名
- (BOOL) xf_isValidateUserName
{
    NSString *userNameRegex = @"^[A-Za-z0-9\u4e00-\u9fa5]{1,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:self];
}

//密码
- (BOOL) xf_isValidatePassword
{
    NSString *regex = @"^\\w+$";
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regextestcm evaluateWithObject:self];
//
//    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}+$";
//    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
//    return [passWordPredicate evaluateWithObject:self];
}

//昵称
- (BOOL) xf_isValidateNickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}

//身份证号
- (BOOL) xf_isValidateIdentityCard
{
    BOOL flag = NO;
    if (self.length <= 0) {
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

- (NSString *)xf_trimExtraDot
{
    if (!self.length) {
        return self;
    }
    
    NSArray *array = [self componentsSeparatedByString:@"."];
    NSInteger intNumber = [[array xf_safeObjectAtIndex:0] integerValue];
    NSString *floatNumber = [array xf_safeObjectAtIndex:1];
    if (!floatNumber) {
        return self;
    } else {
        NSString *display = [NSNumberFormatter localizedStringFromNumber:@(intNumber)
                                                             numberStyle:NSNumberFormatterDecimalStyle];
        if ([floatNumber integerValue] == 0) {
            return display;
        } else {
            return [NSString stringWithFormat:@"%@.%@",display, floatNumber];
        }
    }
}

//是否包含
- (BOOL)xf_contains:(NSString *)string
{
    NSRange range = [self rangeOfString:string];
    return (range.location != NSNotFound);
}

- (NSString *)xf_fileName
{
    NSString *lastPath = [self lastPathComponent];
    lastPath = [lastPath stringByReplacingOccurrencesOfString:@"" withString:@"/"];
    if ([lastPath pathExtension].length > 0) {
        return [[lastPath componentsSeparatedByString:@"."] firstObject];
    }
    return lastPath;
}

- (NSString *)xf_md5
{
    if (!self) {
        return nil;
    }
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)(strlen(cStr)), result );
    
    NSString* s = [NSString stringWithFormat:
                   @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                   result[0], result[1], result[2], result[3],
                   result[4], result[5], result[6], result[7],
                   result[8], result[9], result[10], result[11],
                   result[12], result[13], result[14], result[15]
                   ];
    return s;
}

- (NSString *)xf_formatPhoneNumber
{
    if (self.length != 11) {
        return self;
    }
    
    NSMutableString *format = [NSMutableString string];
    [format appendString:[self substringWithRange:NSMakeRange(0, 3)]];
    [format appendString:@" "];
    [format appendString:[self substringWithRange:NSMakeRange(3, 4)]];
    [format appendString:@" "];
    [format appendString:[self substringWithRange:NSMakeRange(7, 4)]];
    return [NSString stringWithString:format];
}

- (BOOL)xf_containsChinese
{
    for (NSUInteger i = 0; i < self.length; i++) {
        if (((int)[self characterAtIndex:i]) > 127) {
            return YES;
        }
    }
    return NO;
}

@end
