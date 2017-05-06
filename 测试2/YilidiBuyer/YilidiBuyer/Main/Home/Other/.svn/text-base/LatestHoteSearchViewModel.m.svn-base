//
//  LatestHoteSearchViewModel.m
//  YilidiBuyer
//
//  Created by yld on 16/5/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "LatestHoteSearchViewModel.h"
#import "CommonCategaryModel.h"
#import "DLCacheManager.h"
#import "SUIUtils.h"
@implementation LatestHoteSearchViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hasSearchHistory = YES;
    }
    return self;
}

- (RACSignal *)trigerHoteSearchDataRequestSignal {
    
    return [AFNHttpRequestOPManager rac_PostWithSubUrl:kUrl_GoodsSearchHoteKey parameters:nil subScribeResultBlock:^RACDisposable *(id result, NSError *error, id<RACSubscriber> subscriber) {
        NSArray *keyArr = result[EntityKey];
        NSArray *transteredArr =  [keyArr sui_map:^CommonCategaryModel *(NSDictionary * obj, NSUInteger index) {
            CommonCategaryModel *model = [[CommonCategaryModel alloc] init];
            model.categaryName = obj[@"value"];
            return model;
        }];
        [subscriber sendNext:transteredArr];
        [subscriber sendCompleted];
        return nil;
    }];
}

- (void)clearHistorySearchData {
    
    self.hasSearchHistory = NO;
    [[DLCacheManager sharedManager] clearGoodsSearchKeyWordsCache];
}

- (NSArray *)getHistorySearchData {
    
    NSArray *cachedGoodsSearchData = [DLCacheManager sharedManager].cachedGoodsSearchKeyWordsHistoryDatas;
    self.hasSearchHistory = cachedGoodsSearchData.count;
    if (cachedGoodsSearchData.count > 0) {
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:cachedGoodsSearchData.count];
        for (NSString *cachedKey in cachedGoodsSearchData) {
            CommonCategaryModel *model = [[CommonCategaryModel alloc] init];
            model.categaryName = cachedKey;
            [tempArr addObject:model];
        }
        return [tempArr copy];
    }
    
    return nil;
}

- (NSArray *)getTestHoteSearchData {
    CommonCategaryModel *model1 = [[CommonCategaryModel alloc] init];
    model1.categaryName = @"香蕉";
    CommonCategaryModel *model2 = [[CommonCategaryModel alloc] init];
    model2.categaryName = @"粮油面";
    CommonCategaryModel *model3 = [[CommonCategaryModel alloc] init];
    model3.categaryName = @"哈密瓜";
    CommonCategaryModel *model4 = [[CommonCategaryModel alloc] init];
    model4.categaryName = @"葡萄籽哈哈密瓜";
    return @[model1,model2,model3,model4];
}

@end
