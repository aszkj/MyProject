//
//  DataManager.m
//  YilidiBuyer
//
//  Created by yld on 16/6/11.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DataManager.h"

static DataManager *_dataManager = nil;

@implementation DataManager

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _dataManager = [[DataManager alloc] init];
        
    });
    return _dataManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userDataManager = [UserDataManager sharedManager];
        self.communityDataManager = [CommunityDataManager sharedManager];
    }
    return self;
}



@end
