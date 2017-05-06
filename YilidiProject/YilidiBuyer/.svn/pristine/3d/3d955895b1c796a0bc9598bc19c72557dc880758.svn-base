//
//  DLGlobleRequestApiManager.h
//  YilidiBuyer
//
//  Created by yld on 16/5/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GoodsModel;
typedef void(^RequestResultBlock)(id result, NSError *error);

@interface DLGlobleRequestApiManager : NSObject

+ (instancetype)sharedManager;

- (void)requestCanbeShippedCityListWithBackBlock:(RequestResultBlock)requestResultBlock;

- (void)requestCanbeShippedTimeListWithBackBlock:(RequestResultBlock)requestResultBlock;

@property (nonatomic,copy)NSArray *canbeShippedCityList;

@property (nonatomic,copy)NSArray *canbeShippedTimeList;

@property (nonatomic,copy)NSArray *homeIconUrlList;

#pragma mark - request home icon list
- (void)requestHomeIconListBackBlock:(RequestResultBlock)requestResultBlock;

#pragma mark - vip / penny goods
- (void)requestVipGoodsWithBackBlock:(RequestResultBlock)requestResultBlock;

- (void)requestPennyGoodsWithBackBlock:(RequestResultBlock)requestResultBlock;

@property (nonatomic,copy)NSArray *vipGoods;

@property (nonatomic,copy)NSArray *pennyGoods;

@property (nonatomic,assign)BOOL hasGotVipAndPennyGoods;

-(GoodsModel *)vipGoodsModelOfGoodsId:(NSString *)goodsId;

-(GoodsModel *)pennyGoodsModelOfGoodsId:(NSString *)goodsId;


@end
