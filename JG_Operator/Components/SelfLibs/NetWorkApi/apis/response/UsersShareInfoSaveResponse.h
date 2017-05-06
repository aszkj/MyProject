//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"

@interface UsersShareInfoSaveResponse :  AbstractResponse
//app我的分享设置内容
@property (nonatomic, readonly, copy) NSString *shareInfo;
//是否保存成功
@property (nonatomic, readonly, copy) NSNumber *isSaveSuccess;
@end
