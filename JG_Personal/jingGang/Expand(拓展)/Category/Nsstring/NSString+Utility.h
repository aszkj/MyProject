//
//  NSString+InputView.h
//  BBAsk
//
//  Created by nolan on 14-7-11.
//  Copyright (c) 2014年 nolan.inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utility)

// 去除首尾空格或换行符
- (NSString *)xf_stringByTrimingWhitespaceOrNewlineCharacter;

// 去除所有的空格
- (NSString *)xf_stringByTrimingAllWhitespaces;

// 返回行数
- (NSUInteger)xf_numberOfLines;

// 判断是否为整形：
- (BOOL)xf_isPureInt;

// 判断是否为浮点形：
- (BOOL)xf_isPureFloat;

// convert 1000000 to 1000,000
- (NSString *)xf_readableDecimalNumber;

// convert 10000,00 to 1000000
- (NSString *)xf_convertReadableToNumberString;

// convert (100.0 to 100, 100.1 to 100.10, 100.00 to 100, 100.22 to 100.22, 100.02 to 100.02, 100.20 to 100.20)
- (NSString *)xf_tidyReadableNumber;

- (NSString *)xf_tidyReadableRateNumber;

// 手机号码验证
- (BOOL)xf_isValidatePhoneNumber;

// 用户名
- (BOOL)xf_isValidateUserName;

// 密码
- (BOOL)xf_isValidatePassword;

// 昵称
- (BOOL)xf_isValidateNickname;

// 邮箱
- (BOOL) xf_isValidateEmail;

// 身份证号
- (BOOL)xf_isValidateIdentityCard;

// 小数部分全部为0时去掉小数点及后面的0
- (NSString *)xf_trimExtraDot;

// 是否包含
- (BOOL)xf_contains:(NSString *)string;

// 获取文件名称
- (NSString *)xf_fileName;

// xf5
- (NSString *)xf_md5;

// 返回格式化后的手机号 (若不是11位 直接返回)
- (NSString *)xf_formatPhoneNumber;

- (BOOL)xf_containsChinese;

@end
