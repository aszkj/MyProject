//
//  NSDictionary+Print.h
//  JDBClient
//
//  Created by You Tu on 15/1/16.
//  Copyright (c) 2015年 JDB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Print)

- (NSString *)xf_description;  // 递归遍历打印 NSDictionary key value 可显示中文

@end
