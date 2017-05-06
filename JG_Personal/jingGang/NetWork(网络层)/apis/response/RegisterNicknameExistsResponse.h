//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"

@interface RegisterNicknameExistsResponse :  AbstractResponse
//是否存在
@property (nonatomic, readonly, copy) NSNumber *isExists;
//邀请码
@property (nonatomic, readonly, copy) NSNumber *existsCode;
@end
