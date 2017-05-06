//
//  UserDataManager+passwd.h
//  YilidiBuyer
//
//  Created by yld on 16/6/11.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "UserDataManager.h"

@interface UserDataManager (passwd)

+(void)savePassWord:(NSString *)password;

+(id)readPassWord;

+(void)deletePassWord;


@end
