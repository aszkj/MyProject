//
//  DLCacheManager.h
//  YilidiBuyer
//
//  Created by yld on 16/6/2.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CommunityModel;
@interface DLCacheManager : NSObject

+ (instancetype)sharedManager;

#pragma mark - goods search cache
@property (nonatomic,copy)NSArray *cachedGoodsSearchKeyWordsHistoryDatas;
- (void)cacheGoodsSearchKeyWords:(NSString *)goodsSearchKeyWords;
- (void)clearGoodsSearchKeyWordsCache;

#pragma mark - nearby region search cache
@property (nonatomic,copy)NSArray *cachedNearbyRegionSearchHistoryDatas;
- (void)cacheNearbyRegionSearchWithAdressModel:(CommunityModel *)adressModel;
- (void)clearNearbyRegionSearchCache;


- (void)doCache;

@end
