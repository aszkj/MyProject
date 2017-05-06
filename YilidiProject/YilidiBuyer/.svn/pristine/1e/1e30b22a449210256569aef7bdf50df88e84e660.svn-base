//
//  UserDataManager.m
//  YilidiBuyer
//
//  Created by yld on 16/6/8.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "UserDataManager.h"
#import "CHKeychain.h"
#import "TMCache.h"

static UserDataManager *_userDataManager = nil;

static NSString *userInfoCacheKey = @"userInfoCacheKey";

@interface UserDataManager()

@property (nonatomic,strong)DLUserInfoModel *userInfoModel;

@end

@implementation UserDataManager

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _userDataManager = [[UserDataManager alloc] init];
        
    });
    
    return _userDataManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInfoModel = [[TMCache sharedCache] objectForKey:userInfoCacheKey];
    }
    return self;
}



- (BOOL)userIsLogin {
    if (isEmpty(self.userInfoModel)) {
        return NO;
    }else {
        if (isEmpty(self.userInfoModel.userId)) {
            return NO;
        }else {
            return YES;
        }
    }
}

- (void)clearUserInfo {
    
    self.userInfoModel = nil;
    [[TMCache sharedCache] setObject:nil forKey:userInfoCacheKey block:nil];
    [[TMCache sharedCache] removeObjectForKey:userInfoCacheKey];
}

- (DLUserInfoModel *)userInfo {
    
    return self.userInfoModel;
    
}

- (void)saveUserInfo:(NSDictionary *)userInfo {
    DLUserInfoModel *userInfoModel = [[DLUserInfoModel alloc] initWithDefaultDataDic:userInfo];
    self.userInfoModel = userInfoModel;
    [[TMCache sharedCache] setObject:userInfoModel forKey:userInfoCacheKey block:nil];
    
}

- (void)saveUserModel:(DLUserInfoModel *)userModel {
    
    self.userInfoModel = userModel;
    [[TMCache sharedCache] setObject:userModel forKey:userInfoCacheKey block:nil];
    
}


@end

