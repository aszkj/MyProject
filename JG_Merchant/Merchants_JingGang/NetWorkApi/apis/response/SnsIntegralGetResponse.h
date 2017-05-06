//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "RecommendStore.h"
#import "RecommendGoods.h"

@interface SnsIntegralGetResponse :  AbstractResponse
//自测题套题ID
@property (nonatomic, readonly, copy) NSNumber *groupId;
//自测题结果
@property (nonatomic, readonly, copy) NSString *checkResult;
//积分
@property (nonatomic, readonly, copy) NSNumber *integral;
//推荐的商品
@property (nonatomic, readonly, copy) NSArray *recommedGoodsList;
//推荐的店铺
@property (nonatomic, readonly, copy) NSArray *recommedStoreList;
//测试id
@property (nonatomic, readonly, copy) NSNumber *resultId;
@end
