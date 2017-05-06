//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "PositionAdvertBO.h"

@interface SnsRecommendListResponse :  AbstractResponse
//推荐位对应的所有推荐
@property (nonatomic, readonly, copy) NSArray *advList;
@end
