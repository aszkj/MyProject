//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "Circle.h"

@interface UsersCircleListResponse :  AbstractResponse
//圈子列表
@property (nonatomic, readonly, copy) NSArray *circle;
//圈子信息
@property (nonatomic, readonly, copy) Circle *circleInfo;
@end
