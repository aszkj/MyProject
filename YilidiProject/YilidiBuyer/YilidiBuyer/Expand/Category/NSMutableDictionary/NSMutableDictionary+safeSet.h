//
//  NSMutableDictionary+safeSet.h
//  YilidiBuyer
//
//  Created by mm on 16/12/21.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DicSaveSetObject(dic,key,value)  [dic saveSetObject:value forKey:key]

@interface NSMutableDictionary (safeSet)

- (void)saveSetObject:(id)object forKey:(NSString *)key;

@end
