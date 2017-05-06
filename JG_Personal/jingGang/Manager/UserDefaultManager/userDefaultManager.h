//
//  userDefaultManager.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userDefaultManager : NSObject


// 从本地数据库获对应key值下的数据(字符串)
+ (NSString *) GetLocalDataString:(NSString *)aKey;
// 设置本地数据库对应key值下的数据(字符串)
+ (void) SetLocalDataString:(NSString *)aValue key:(NSString *)aKey;
// 从本地数据库获对应key值下的(object)
+ (id) GetLocalDataObject:(NSString *)aKey;
// 设置本地数据库对应key值下的数据(字object串)
+ (void) SetLocalDataObject:(id)aValue key:(NSString *)aKey;
//删除本地数据
+ (void) removeLocalDataForKey:(NSString *)akey;
//删除所有数据
+(void)removeAllObject;


@end
