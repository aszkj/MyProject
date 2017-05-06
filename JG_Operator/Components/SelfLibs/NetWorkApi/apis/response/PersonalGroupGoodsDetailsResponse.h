//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "PGroupGoods.h"
#import "PGroup.h"
#import "GroupArea.h"

@interface PersonalGroupGoodsDetailsResponse :  AbstractResponse
//地区
@property (nonatomic, readonly, copy) GroupArea *areaBO;
//促销推荐
@property (nonatomic, readonly, copy) NSArray *groupGoodsBOs;
//热门城市
@property (nonatomic, readonly, copy) NSArray *hotCityList;
//店铺详情
@property (nonatomic, readonly, copy) PGroup *storeInfo;
@end
