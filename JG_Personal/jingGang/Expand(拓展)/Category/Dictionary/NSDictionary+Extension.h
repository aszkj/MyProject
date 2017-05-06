//
//  NSDictionary+MDP.h
//  MDPFramework
//
//  Created by 谢进展 on 14-4-6.
//  Copyright (c) 2014年 谢进展. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSDictionary (Extension)

//url转字符串
- (NSString*)xf_urlEncodedKeyValueString;
//json转字符串
- (NSString*)xf_jsonEncodedKeyValueString;
//plist转字符串
- (NSString*)xf_plistEncodedKeyValueString;

@end

@interface NSDictionary (CGStructs)

- (CGPoint)xf_pointForKey:(NSString *)key;
- (CGSize)xf_sizeForKey:(NSString *)key;
- (CGRect)xf_rectForKey:(NSString *)key;
- (CGAffineTransform)xf_affineTransformForKey:(NSString *)key;
- (NSString *)xf_stringForKey:(id)key;
- (NSNumber *)xf_numberForKey:(id)key;

// 返回http request (如 user_id=123456&user_name=jdb)
- (NSString *)xf_httpRequestBody;

@end
