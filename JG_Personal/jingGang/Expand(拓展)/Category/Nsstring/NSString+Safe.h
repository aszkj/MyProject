//
//  NSString+Safe.h
//  JDBClient
//
//  Created by You Tu on 15/1/6.
//  Copyright (c) 2015年 JDB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Safe)

- (unichar)xf_safeCharacterAtIndex:(NSUInteger)index;

- (NSString *)xf_safeSubstringToIndex:(NSUInteger)index;

- (NSString *)xf_safeSubstringFromIndex:(NSUInteger)index;

@end
