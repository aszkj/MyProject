//
//  GoodsModel.m
//  YilidiBuyer
//
//  Created by yld on 16/5/23.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "GoodsModel.h"
#import "DLGlobleRequestApiManager.h"
#import "ProjectRelativeDefineNotification.h"

@implementation GoodsModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.barCode = dic[@"barCode"];
        self.goodsId = [dic[@"saleProductId"] stringValue];
        self.productId = [dic[@"productId"] stringValue];
        self.goodsName = dic[@"saleProductName"];
        self.goodsOriginalPrice = dic[@"retailPrice"];
        self.goodsOriginalPrice = @(self.goodsOriginalPrice.floatValue/1000.0);
        self.goodsVipPrice = dic[@"promotionalPrice"];
        self.goodsVipPrice = @(self.goodsVipPrice.floatValue/1000.0);
        self.goodsThumbnail = dic[@"saleProductImageUrl"];
        self.goodsStand = dic[@"saleProductSpec"];
        self.productDetail = dic[@"productDetail"];
        self.goodsStock = dic[@"stockNum"];
        self.goodsOrderPrice = dic[@"orderPrice"];
        self.seckillActivityId = [dic[@"actId"] stringValue];
        self.goodsOrderPrice = @(self.goodsOrderPrice.floatValue/1000.0);
        self.goodsType =  GoodsType_Unknown;
        self.goodsOnShelf = @1;
        [self registerVipPennyGoodsGotNotification];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self dealGoodsType];
        });
    
    }
    return self;
}

@end



@implementation GoodsModel (objectGoodsModel)

+ (NSArray *)objectGoodsModelWithGoodsArr:(NSArray *)goodsArr
{
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:goodsArr.count];
    for (NSDictionary *dic in goodsArr) {
        GoodsModel *model = [[GoodsModel alloc] initWithDefaultDataDic:dic];
        [tempArr addObject:model];
    }
    return [tempArr copy];
}

@end

@implementation GoodsModel (objectSecKillGoodsModel)

+ (NSArray *)objectSecKillGoodsModelWithGoodsArr:(NSArray *)goodsArr {
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:goodsArr.count];
    for (NSDictionary *dic in goodsArr) {
        GoodsModel *model = [[GoodsModel alloc] initWithDefaultDataDic:dic];
        model.seckillPrice = dic[@"seckillPrice"];
        model.seckillPrice = @(model.seckillPrice.floatValue/1000);
        model.seckillTotalCount = dic[@"seckillTotalCount"];
        model.seckillShowTotalCount = dic[@"seckillShowTotalCount"];
        model.isAbleToSeckill = dic[@"isAbleToSeckill"];
        model.limitBuyNumber = dic[@"limitCount"];
        [tempArr addObject:model];
    }
    return [tempArr copy];
}

@end


@implementation GoodsModel (dealShopCartGoods)

-(ShopCartGoodsStatus)shopCartGoodsStatus {

    if (!self.goodsOnShelf.integerValue) {
        return ShopCartGoodsStatus_isOffShelf;
    }else if(!self.limitBuyNumber.integerValue){
        if (!isEmpty(self.seckillActivityId)) {
            return ShopCartGoodsStatus_hasGrabedOver;
        }else {
            return ShopCartGoodsStatus_hasGot;
        }
    }else if(!self.goodsStock.integerValue){
        if (!isEmpty(self.seckillActivityId)) {
            return ShopCartGoodsStatus_hasGrabedOver;
        }else {
            return ShopCartGoodsStatus_NoStock;
        }
    }
    return ShopCartGoodsStatus_canBuy;
}

@end


@implementation GoodsModel (objectOrderGoodsModel)

+ (NSArray *)objectOrderGoodsModelWithGoodsArr:(NSArray *)goodsArr
{
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:goodsArr.count];
    for (NSDictionary *dic in goodsArr) {
        GoodsModel *model = [[GoodsModel alloc] init];
        model.goodsThumbnail = dic[@"orderImage"];
        [tempArr addObject:model];
    }
    return [tempArr copy];
}

@end

@implementation GoodsModel (dealGoodsType)
- (void)registerVipPennyGoodsGotNotification {
    [kNotification addObserver:self selector:@selector(observeVipPennyGoodsGotNotification:) name:KNotificationGotVipPennyGoods object:nil];
}

- (GoodsType)dealGoodsType{
    if (![DLGlobleRequestApiManager sharedManager].hasGotVipAndPennyGoods) {
        return GoodsType_Unknown;
    }
    
    if (self.goodsType != GoodsType_Unknown) {
        return self.goodsType;
    }
    
    self.goodsType = [self _getGoodsTypeOfGoodsId:self.goodsId];
    return self.goodsType;
}


#pragma mark -------------------Private Method----------------------
- (GoodsType)_getGoodsTypeOfGoodsId:(NSString *)goodsId {
    if ([self _isVipGoodsOfGoodsId:goodsId]) {
        return GoodsType_VipGoods;
    }else if ([self _isPennyGoodsOfGoodsId:goodsId]){
        return GoodsType_NormalPennyGoods;
    }else {
        return GoodsType_NormalGoods;
    }
}

- (BOOL)_isVipGoodsOfGoodsId:(NSString *)goodsId {
    DLGlobleRequestApiManager *globleRequestApiManager = [DLGlobleRequestApiManager sharedManager];
    NSArray *vipGoods = globleRequestApiManager.vipGoods;
    if (!vipGoods.count) {
        return NO;
    }
    __block BOOL isVipGoods = NO;
    [vipGoods enumerateObjectsUsingBlock:^(GoodsModel *vipGoodsModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([vipGoodsModel.goodsId isEqualToString:goodsId]) {
            isVipGoods = YES;
            *stop = YES;
        }
    }];
    return isVipGoods;
}

- (BOOL)_isPennyGoodsOfGoodsId:(NSString *)goodsId {
    DLGlobleRequestApiManager *globleRequestApiManager = [DLGlobleRequestApiManager sharedManager];
    NSArray *pennyGoods = globleRequestApiManager.pennyGoods;
    if (!pennyGoods.count) {
        return NO;
    }
    __block BOOL ispennyGoods = NO;
    [pennyGoods enumerateObjectsUsingBlock:^(GoodsModel *dennyGoodsModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([dennyGoodsModel.goodsId isEqualToString:goodsId]) {
            ispennyGoods = YES;
            *stop = YES;
        }
    }];
    return ispennyGoods;
    
}

#pragma mark -------------------Notification Method----------------------
- (void)observeVipPennyGoodsGotNotification:(NSNotification *)info {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self dealGoodsType];
    });
}

#pragma mark -------------------Delloc Method----------------------
- (void)dealloc
{
    [kNotification removeObserver:self];
}

@end






