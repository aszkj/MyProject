//
//  UserDataManager.h
//  YilidiBuyer
//
//  Created by yld on 16/6/8.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLUserInfoModel.h"

/**
 *  用户数据信息包括，用户基本信息，用户收货地址信息，用户当前位置信息，用户购物车信息等
 */
@interface UserDataManager : NSObject

+ (instancetype)sharedManager;

- (BOOL)userIsLogin;

- (void)saveUserInfo:(NSDictionary *)userInfo;

- (DLUserInfoModel *)userInfo;

- (void)clearUserInfo;

- (void)saveUserModel:(DLUserInfoModel *)userModel;

@end
