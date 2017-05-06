//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"

@interface UsersInvitationDetailsResponse :  AbstractResponse
//帖子id
@property (nonatomic, readonly, copy) NSNumber *apiId;
//帖子图片
@property (nonatomic, readonly, copy) NSString *thumbnail;
//帖子内容
@property (nonatomic, readonly, copy) NSString *content;
//app分享类型(1：android ,2 ： ios)
@property (nonatomic, readonly, copy) NSNumber *jgAppType;
@end
