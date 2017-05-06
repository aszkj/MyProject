//
//  UserDataManager.h
//  YilidiBuyer
//
//  Created by yld on 16/6/8.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataManager : NSObject

+(void)savePassWord:(NSString *)password;

+(id)readPassWord;

+(void)deletePassWord;

@end
