//
//  UserDataManager+passwd.m
//  YilidiBuyer
//
//  Created by yld on 16/6/11.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "UserDataManager+passwd.h"

static NSString * const KEY_PASSWORD_IN_KEYCHAIN = @"KEY_PASSWORD_IN_KEYCHAIN";
static NSString * const KEY_PASSWORD = @"KEY_PASSWORD";

@implementation UserDataManager (passwd)

+(void)savePassWord:(NSString *)password
{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:password forKey:KEY_PASSWORD];
    [CHKeychain save:KEY_PASSWORD_IN_KEYCHAIN data:usernamepasswordKVPairs];
}

+(id)readPassWord
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[CHKeychain load:KEY_PASSWORD_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_PASSWORD];
}

+(void)deletePassWord
{
    [CHKeychain delete:KEY_PASSWORD_IN_KEYCHAIN];
}


@end
