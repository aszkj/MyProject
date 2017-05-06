//
//  DLCacheManager.m
//  YilidiSeller
//
//  Created by yld on 16/6/2.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLCacheManager.h"
#import "TMCache.h"
#import "AdressModel.h"
#import "SUIUtils.h"

static NSString *goodsSearchCacheKey = @"goodsSearchCacheKey";
static NSString *nearbyRegionSearchCacheKey = @"nearbyRegionSearchCacheKey";
const NSInteger MAX_GOODS_SEARCH_CACHE_COUNT = 10;
const NSInteger MAX_NEARBY_REGION_SEARCH_CACHE_COUNT = 6;

static DLCacheManager *_cacheManager = nil;

@interface DLCacheManager()

@property (nonatomic, strong)TMCache *cache;

@end

@implementation DLCacheManager

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _cacheManager = [[DLCacheManager alloc] init];
        
    });
    return _cacheManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cache = [TMCache sharedCache];
    }
    return self;
}

#pragma mark -------------------Public Method----------------------
- (void)cacheGoodsSearchKeyWords:(NSString *)goodsSearchKeyWords {
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:self.cachedGoodsSearchKeyWordsHistoryDatas];
    BOOL hasThisKeyBefore = [tempArr containsObject:goodsSearchKeyWords];
    if (hasThisKeyBefore) {
        NSInteger thisKeyIndex = [tempArr indexOfObject:goodsSearchKeyWords];
        if (thisKeyIndex) {
            [tempArr exchangeObjectAtIndex:0 withObjectAtIndex:thisKeyIndex];
        }
    }else {
        [tempArr insertObject:goodsSearchKeyWords atIndex:0];
        if (tempArr.count > MAX_GOODS_SEARCH_CACHE_COUNT) {
            [tempArr removeLastObject];
        }
    }
    self.cachedGoodsSearchKeyWordsHistoryDatas = [tempArr copy];
}

- (void)clearGoodsSearchKeyWordsCache {
    self.cachedGoodsSearchKeyWordsHistoryDatas = nil;
}

- (void)cacheNearbyRegionSearchWithAdressModel:(AdressModel *)adressModel {
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:self.cachedNearbyRegionSearchHistoryDatas];
    BOOL hasThisKeyBefore = NO;
    NSInteger thisKeyIndex = -1000;
    for (NSInteger i=0; i<tempArr.count; i++) {
        AdressModel *model = tempArr[i];
        if ([model.consigneAdressId isEqualToString:adressModel.consigneAdressId]) {
            hasThisKeyBefore = YES;
            thisKeyIndex = i;
            break;
        }
    }
    if (hasThisKeyBefore) {
        if (thisKeyIndex != -1000) {
            [tempArr exchangeObjectAtIndex:0 withObjectAtIndex:thisKeyIndex];
        }
    }else {
        [tempArr insertObject:adressModel atIndex:0];
        if (tempArr.count > MAX_NEARBY_REGION_SEARCH_CACHE_COUNT) {
            [tempArr removeLastObject];
        }
    }
    self.cachedNearbyRegionSearchHistoryDatas = [tempArr copy];
}

- (void)clearNearbyRegionSearchCache {
    self.cachedNearbyRegionSearchHistoryDatas = nil;
}

- (void)doCache {
    
    [_cache setObject:self.cachedGoodsSearchKeyWordsHistoryDatas forKey:goodsSearchCacheKey];

    [_cache setObject:self.cachedGoodsSearchKeyWordsHistoryDatas forKey:nearbyRegionSearchCacheKey];
}


#pragma mark -------------------Setter/Getter Method----------------------
- (NSArray *)cachedNearbyRegionSearchHistoryDatas {
    
    if (!_cachedNearbyRegionSearchHistoryDatas) {
        NSArray *cachedNearbyRegionSearchData = (NSArray *)[_cache objectForKey:nearbyRegionSearchCacheKey];
        NSArray *tempArr = [NSArray array];
        if (!isEmpty(cachedNearbyRegionSearchData)) {
            tempArr = [NSArray arrayWithArray:cachedNearbyRegionSearchData];
        }
        _cachedNearbyRegionSearchHistoryDatas = tempArr;
    }
    return _cachedNearbyRegionSearchHistoryDatas;

}

- (NSArray *)cachedGoodsSearchKeyWordsHistoryDatas {
    
    if (!_cachedGoodsSearchKeyWordsHistoryDatas) {
        NSArray *cachedGoodsSearchKeyWordsHistoryData = (NSArray *)[_cache objectForKey:goodsSearchCacheKey];
        NSArray *tempArr = [NSArray array];
        if (!isEmpty(cachedGoodsSearchKeyWordsHistoryData)) {
            tempArr = [NSArray arrayWithArray:cachedGoodsSearchKeyWordsHistoryData];
        }
        _cachedGoodsSearchKeyWordsHistoryDatas = tempArr;
    }
    return _cachedGoodsSearchKeyWordsHistoryDatas;
    
}


@end
