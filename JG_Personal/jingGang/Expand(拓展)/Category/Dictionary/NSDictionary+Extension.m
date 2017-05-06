//
//  NSDictionary+MDP.m
//  MDPFramework
//
//  Created by 谢进展 on 14-4-6.
//  Copyright (c) 2014年 谢进展. All rights reserved.
//

#import "NSDictionary+Extension.h"
#import <UIKit/UIGeometry.h>

@implementation NSDictionary (Extension)

- (NSString*)xf_urlEncodedKeyValueString {
    
    NSMutableString *string = [NSMutableString string];
    for (NSString *key in self) {
        
        NSObject *value = [self valueForKey:key];
        if([value isKindOfClass:[NSString class]])
            [string appendFormat:@"%@=%@&",key,((NSString*)value)];
        else
            [string appendFormat:@"%@=%@&", key, value];
    }
    
    if([string length] > 0)
        [string deleteCharactersInRange:NSMakeRange([string length] - 1, 1)];
    
    return string;
}

- (NSString*)xf_jsonEncodedKeyValueString {
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:0 // non-pretty printing
                                                     error:&error];
    if(error) {
        XFLogDebug(@"JSON Parsing Error: %@", error);
        
        return nil;
    }
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


- (NSString*)xf_plistEncodedKeyValueString {
    
    NSError *error = nil;
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:self
                                                              format:NSPropertyListXMLFormat_v1_0
                                                             options:0 error:&error];
    if(error) {
        XFLogDebug(@"JSON Parsing Error: %@", error);
        
        return nil;
    }
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end


@implementation NSDictionary (CGStructs)

- (CGPoint)xf_pointForKey:(NSString *)key
{
    id obj = [self valueForKey:key];
    if (obj && [obj isKindOfClass:[NSValue class]]) {
        return [(NSValue *)obj CGPointValue];
    }
    return CGPointZero;
}

- (CGSize)xf_sizeForKey:(NSString *)key
{
    id obj = [self valueForKey:key];
    if (obj && [obj isKindOfClass:[NSValue class]]) {
        return [(NSValue *)obj CGSizeValue];
    }
    return CGSizeZero;
}

- (CGRect)xf_rectForKey:(NSString *)key
{
    id obj = [self valueForKey:key];
    if (obj && [obj isKindOfClass:[NSValue class]]) {
        return [(NSValue *)obj CGRectValue];
    }
    return CGRectZero;
}

- (CGAffineTransform)xf_affineTransformForKey:(NSString *)key
{
    id obj = [self valueForKey:key];
    if (obj && [obj isKindOfClass:[NSValue class]]) {
        return [(NSValue *)obj CGAffineTransformValue];
    }
    return CGAffineTransformIdentity;

}

- (NSString *)xf_stringForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    }
    else if ([obj isKindOfClass:[NSNumber class]]){
        return [(NSNumber *)obj stringValue];
    }
    return nil;
}

- (NSNumber *)xf_numberForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]]) {
        return @([obj doubleValue]);
    }
    else if ([obj isKindOfClass:[NSNumber class]]){
        return obj;
    }
    return nil;
}

- (NSString *)xf_httpRequestBody
{
    NSMutableString *requestBody = [NSMutableString string];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [requestBody appendFormat:@"&%@=%@", key, obj];
    }];
    
    NSString *body = nil;
    if (requestBody.length > 1) {
        body = [requestBody substringFromIndex:1];
    }
    
    return body;
}

@end



