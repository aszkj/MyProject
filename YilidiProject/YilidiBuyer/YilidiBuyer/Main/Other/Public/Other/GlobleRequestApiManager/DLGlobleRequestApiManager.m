//
//  DLGlobleRequestApiManager.m
//  YilidiBuyer
//
//  Created by yld on 16/5/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGlobleRequestApiManager.h"
#import "DLReceiveTimeModel.h"
#import "GlobleConst.h"
#import "ProjectRelativeDefineNotification.h"
#import "NSArray+SUIAdditions.h"
#import "ProjectRelativeKey.h"
static DLGlobleRequestApiManager *_shareGlobleRequestApiManager = nil;

@implementation DLGlobleRequestApiManager


+ (instancetype)sharedManager{
    
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _shareGlobleRequestApiManager = [[DLGlobleRequestApiManager alloc] init];
        
    });
    
    return _shareGlobleRequestApiManager;
}

- (void)requestHomeIconListBackBlock:(RequestResultBlock)requestResultBlock {
    
    [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_GetHomeIconUrlList parameters:nil block:^(id result, NSError *error) {
        self.homeIconUrlList = result[@"data"];
        emptyBlock(requestResultBlock,self.homeIconUrlList,error);
    }];

}

- (void)requestCanbeShippedCityListWithBackBlock:(RequestResultBlock)requestResultBlock {
    [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_CanbeShippedCityList parameters:nil block:^(id result, NSError *error) {
        self.canbeShippedCityList = result[@"data"];
        emptyBlock(requestResultBlock,self.canbeShippedCityList,error);
    }];
}

- (void)requestCanbeShippedTimeListWithBackBlock:(RequestResultBlock)requestResultBlock {
    [AFNHttpRequestOPManager getInfoWithSubUrl:kUlr_CanbeshippedTimeList parameters:nil block:^(id result, NSError *error) {
        NSArray *resultArr = result[@"data"];
        self.canbeShippedTimeList = [DLReceiveTimeModel objectGoodsModelWithGoodsArr:resultArr];
        emptyBlock(requestResultBlock,self.canbeShippedTimeList,error);
    }];
}

- (void)requestVipGoodsWithBackBlock:(RequestResultBlock)requestResultBlock {
  
    NSDictionary *requestParam = @{@"zoneType":@(kPerfectureGoodsTypeVIPNumber),
                                   KStoreIdKey:kCommunityStoreId};
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_GetPerfectureGoods block:^(NSDictionary *resultDic, NSError *error) {
        emptyBlock(requestResultBlock,resultDic,error);
        NSArray *vipGoods = resultDic[EntityKey];
        self.vipGoods = [self _getGoodsIdsWithGoodsArr:vipGoods];
        self.hasGotVipAndPennyGoods = YES;
        [kNotification postNotificationName:KNotificationGotVipPennyGoods object:nil];
    }];
}


- (void)requestPennyGoodsWithBackBlock:(RequestResultBlock)requestResultBlock {
    NSDictionary *requestParam = @{@"zoneType":@(kPerfectureGoodsTypePennyGoodsNumber),
                                    KStoreIdKey:kCommunityStoreId};
    self.hasGotVipAndPennyGoods = NO;
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_GetPerfectureGoods block:^(NSDictionary *resultDic, NSError *error) {
        NSArray *pennyGoods = resultDic[EntityKey];
        self.pennyGoods = [self _getGoodsIdsWithGoodsArr:pennyGoods];
        emptyBlock(requestResultBlock,resultDic,error);
    }];
}

- (NSArray *)_getGoodsIdsWithGoodsArr:(NSArray *)goodsArr {
    if (isEmpty(goodsArr)) {
        return @[];
    }
    if (!goodsArr.count) {
        return @[];
    }
    return [goodsArr sui_map:^GoodsModel *(NSDictionary * goodsDic, NSUInteger index) {
        return [[GoodsModel alloc] initWithDefaultDataDic:goodsDic];
    }];
}

- (GoodsModel *)_goodsModelOfGoodsId:(NSString *)goodsId atGoodsArr:(NSArray *)goodsArr{
    __block GoodsModel *findModel = nil;
    [goodsArr enumerateObjectsUsingBlock:^(GoodsModel *goodsModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([goodsModel.goodsId isEqualToString:goodsId]) {
            findModel = goodsModel;
            * stop = YES;
        }
    }];
    
    return findModel;
}

-(GoodsModel *)vipGoodsModelOfGoodsId:(NSString *)goodsId {
    
    return [self _goodsModelOfGoodsId:goodsId atGoodsArr:self.vipGoods];
}

-(GoodsModel *)pennyGoodsModelOfGoodsId:(NSString *)goodsId {

    return [self _goodsModelOfGoodsId:goodsId atGoodsArr:self.pennyGoods];

}


@end
