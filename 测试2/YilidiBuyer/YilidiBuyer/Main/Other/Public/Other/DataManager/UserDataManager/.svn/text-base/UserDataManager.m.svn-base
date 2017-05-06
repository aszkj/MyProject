//
//  UserDataManager.m
//  YilidiBuyer
//
//  Created by yld on 16/6/8.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "UserDataManager.h"
#import "CHKeychain.h"

static UserDataManager *_userDataManager = nil;

@implementation UserDataManager

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _userDataManager = [[UserDataManager alloc] init];
        
    });
    
    return _userDataManager;
}


@end

