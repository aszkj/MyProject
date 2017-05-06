//
//  userDefaultManager.m
//  jingGang
//
//  Created by yi jiehuang on 15/5/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "userDefaultManager.h"

@implementation userDefaultManager


-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

// 从本地数据库获对应key值下的数据(字符串)
+ (NSString *) GetLocalDataString:(NSString *)aKey;
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (nil == defaults || nil == aKey) {
        return nil;
    }
    
    NSString *strRet = [defaults objectForKey:aKey];
    
//    NSLog(@"Avalue = %@ , akey = %@",strRet,aKey);
    return strRet;
}
// 设置本地数据库对应key值下的数据(字符串)
+ (void) SetLocalDataString:(NSString *)aValue key:(NSString *)aKey;
{
//    NSLog(@"Value = %@ ,  key = %@",aValue,aKey);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (nil == defaults || nil == aKey || [aValue isKindOfClass:[NSNull class]] )
    {
        return;
    }
    [defaults setValue:aValue forKey:aKey];
    [defaults synchronize];
}

//删除本地数据
+ (void) removeLocalDataForKey:(NSString *)akey
{
    NSLog(@"删除数据%@",akey);
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:akey];
}

+(void)removeAllObject
{
    NSLog(@"删除所有数据");
    NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [userDefatluts dictionaryRepresentation];
    for(NSString* key in [dictionary allKeys]){
        [userDefatluts removeObjectForKey:key];
        [userDefatluts synchronize];
    }
}

// 设置本地数据库对应key值下的数据
+ (void) SetLocalDataObject:(id)aValue key:(NSString *)aKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (nil == defaults || nil == aKey)
    {
        return;
    }else
    {
//        [defaults removeObjectForKey:aValue];
        [defaults setValue:aValue forKey:aKey];
        NSLog(@"defaults = %@",[defaults objectForKey:aKey]);
        [defaults synchronize];
    }
}

// 从本地数据库获对应key值下的数据(Object)
+ (id) GetLocalDataObject:(NSString *)aKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (nil == defaults || nil == aKey)
    {
        return nil;
    }
    
    id strRet = [defaults objectForKey:aKey];
    //    NSLog(@"strRef111 = %@",strRet);
    return strRet;
}

@end
