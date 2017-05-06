//
//  NSDictionary+Print.m
//  JDBClient
//
//  Created by You Tu on 15/1/16.
//  Copyright (c) 2015年 JDB. All rights reserved.
//

#import "NSDictionary+Print.h"

static NSString *const kSpacePlaceholder = @"   ";

@implementation NSDictionary (Print)

static NSString *spacesWithNumber(int number) {
    NSMutableString *spaces = [[NSMutableString alloc] init];
    for (int i = 0; i < number; i++) {
        [spaces appendString:kSpacePlaceholder];
    }
    return [[NSString alloc] initWithString:spaces];
}

- (NSString *)xf_description {
    NSMutableString *readable = [[NSMutableString alloc] init];
    [NSDictionary xf_printDict:self space:1 mutable:readable];
    return [[NSString alloc] initWithString:readable];
}

+ (void)xf_printDict:(NSDictionary *)dict space:(int)spaceNumber mutable:(NSMutableString *)mutable {
    NSArray *keys = [dict allKeys];
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *key = (NSString *)obj;
        id value = [dict objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            NSMutableString *spaces = [[NSMutableString alloc] init];
            for (int i = 0; i < spaceNumber; i++) {
                [spaces appendString:kSpacePlaceholder];
            }
            
            [mutable appendString:[NSString stringWithFormat:@"\n%@%@ = { ", spaces, key]];
            [self xf_printDict:value space:spaceNumber + 1 mutable:mutable];
            [mutable appendString:[NSString stringWithFormat:@"\n%@}", spaces]];
        } else if ([value isKindOfClass:[NSArray class]]) {
            NSMutableString *spaces = [[NSMutableString alloc] init];
            for (int i = 0; i < spaceNumber; i++) {
                [spaces appendString:kSpacePlaceholder];
            }
            
            [mutable appendString:[NSString stringWithFormat:@"\n%@%@ = (", spaces, key]];
            
            int  newSpaceNumber = spaceNumber + 2;
            for (int i = 0; i < ((NSArray *)value).count; i++) {
                if ([(value)[i] isKindOfClass:[NSDictionary class]]) {
                    [mutable appendString:@"\n"];
                    [mutable appendString:spacesWithNumber(newSpaceNumber)];
                    [mutable appendString:@"{"];
                    
                    [self xf_printDict:value[i] space:newSpaceNumber + 1 mutable:mutable];
                    
                    [mutable appendString:@"\n"];
                    [mutable appendString:spacesWithNumber(newSpaceNumber)];
                    
                    if (i == ((NSArray *)value).count - 1) {
                        [mutable appendString:@"}"];
                    } else {
                        [mutable appendString:@"},"];
                    }
                } else if ([value[i] isKindOfClass:[NSNumber class]]) {
                    [mutable appendString:spacesWithNumber(newSpaceNumber)];
                    [mutable appendString:[NSString stringWithFormat:@"%lf", [(NSNumber *)value[i] floatValue]]];
                    [mutable appendString:@";"];
                    [mutable appendString:@"\n"];
                } else if ([value[i] isKindOfClass:[NSString class]]) {
                    [mutable appendString:spacesWithNumber(newSpaceNumber)];
                    [mutable appendString:value[i]];
                    [mutable appendString:@";"];
                    [mutable appendString:@"\n"];
                }
            }
            [mutable appendString:[NSString stringWithFormat:@"\n%@)", spaces]];
        } else {
            [mutable appendString:spacesWithNumber(spaceNumber)];
            NSString *line = [NSString stringWithFormat:@"\n%@%@ = %@;", spacesWithNumber(spaceNumber), key, value];
            [mutable appendString:line];
        }
    }];
}

@end
