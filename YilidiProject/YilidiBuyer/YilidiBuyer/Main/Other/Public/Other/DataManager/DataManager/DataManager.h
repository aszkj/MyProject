//
//  DataManager.h
//  YilidiBuyer
//
//  Created by yld on 16/6/11.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDataManager.h"
#import "CommunityDataManager.h"

@interface DataManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic,strong)UserDataManager *userDataManager;

@property (nonatomic,strong)CommunityDataManager *communityDataManager;

@end
