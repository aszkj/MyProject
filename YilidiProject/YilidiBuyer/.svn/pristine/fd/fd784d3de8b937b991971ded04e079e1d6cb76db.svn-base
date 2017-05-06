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
#import "NSMutableDictionary+safeSet.h"
#import "ProjectRelativeMaco.h"
#import "NSObject+SUIAdditions.h"
#import "NSString+Teshuzifu.h"
#import "ActivityModel.h"

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
        self.goodsBrandName = dic[@"brandName"];
        self.productDetail = dic[@"productDetail"];
        self.saleProductImageList = dic[@"saleProductImageList"];
        self.goodsStock = dic[@"stockNum"];
        self.goodsOrderPrice = dic[@"orderPrice"];
        self.seckillActivityId = [dic[@"actId"] stringValue];
        self.userHasFavorite = [dic[@"isCollected"] boolValue];
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

- (GoodsStatus)goodsStatus {
    
    switch (self.goodsOnShelf.integerValue) {
        case 0:
            return GoodsStatus_OffShelf;
            break;
        case 3:
            return GoodsStatus_OutOfDate;
            break;
        default:
            break;
    }
    
    if (!self.goodsStock.integerValue) {
        return GoodsStatus_NoStock;
    }
   
    return GoodsStatus_Normal;
}

-(NSDictionary *)goodsModelDic {
    NSMutableDictionary *goodsDic = [NSMutableDictionary dictionaryWithCapacity:0];
    DicSaveSetObject(goodsDic, @"saleProductId", @(self.goodsId.longLongValue));
    DicSaveSetObject(goodsDic, @"brandName", self.goodsBrandName);
    DicSaveSetObject(goodsDic, @"saleProductImageUrl", self.goodsThumbnail);
    DicSaveSetObject(goodsDic, @"saleProductName", self.goodsName);
    DicSaveSetObject(goodsDic, @"saleProductSpec", self.goodsStand);
    DicSaveSetObject(goodsDic, @"retailPrice", PriceMutipl1000(self.goodsOriginalPrice));
    DicSaveSetObject(goodsDic, @"promotionalPrice", PriceMutipl1000(self.goodsVipPrice));
    DicSaveSetObject(goodsDic, @"orderPrice",  PriceMutipl1000(self.goodsOrderPrice));
    DicSaveSetObject(goodsDic, @"productStatus", self.goodsOnShelf);
    DicSaveSetObject(goodsDic, @"stockNum", self.goodsStock);
    DicSaveSetObject(goodsDic, @"cartNum", self.goodsNumber);
    DicSaveSetObject(goodsDic, @"limitCount", self.limitBuyNumber);
    DicSaveSetObject(goodsDic, @"actId", @(self.seckillActivityId.longLongValue));
    DicSaveSetObject(goodsDic, @"barCode", self.barCode);
    
    return [goodsDic copy];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    DDLogVerbose(@"没有定义的key --- %@",key);
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


const void *shopCartGoodsEditKey = @"shopCartGoodsEditKey";
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

- (void)setIsShopCartGoodsEditing:(BOOL)isShopCartGoodsEditing{
    [self sui_setAssociatedAssignObject:@(isShopCartGoodsEditing) key:shopCartGoodsEditKey];
}

- (BOOL)isShopCartGoodsEditing {
    return [[self sui_getAssociatedObjectWithKey:shopCartGoodsEditKey] boolValue];
}

@end


@implementation GoodsModel (objectOrderGoodsModel)

+ (NSArray *)objectOrderGoodsModelWithGoodsArr:(NSArray *)goodsArr
{
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:goodsArr.count];
    for (NSDictionary *dic in goodsArr) {
        GoodsModel *model = [[GoodsModel alloc] init];
        model.goodsThumbnail = dic[@"orderImage"];
        model.goodsId = dic[@"orderImage"];
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

const void *GoodsActivitysKey = @"GoodsActivitysKey";
const void *GoodsActivityDescriptionKey = @"GoodsActivityDescriptionKey";
const void *GoodsActivityDescriptionHeightKey = @"GoodsActivityDescriptionHeightKey";

@implementation GoodsModel (goodsActivicty)

- (void)configureGoodsActivities:(NSArray *)goodsActivitys {
    if (isEmpty(goodsActivitys)) {
        goodsActivitys = @[];
    }
    goodsActivitys = [ActivityModel objectShopCartGoodsActivitys:goodsActivitys];
    self.goodsActivitys = goodsActivitys;
}

- (void)setGoodsActivitys:(NSArray *)goodsActivitys {
    [self sui_setAssociatedCopyObject:goodsActivitys key:GoodsActivitysKey];
    
    ActivityModel *goodsActivityModel = goodsActivitys.firstObject;
    self.goodsActivityDescription = goodsActivityModel.activityName;
}

- (NSArray *)goodsActivitys {
   return  [self sui_getAssociatedObjectWithKey:GoodsActivitysKey];
}

- (void)setGoodsActivityDescription:(NSString *)goodsActivityDescription {
    if (isEmpty(goodsActivityDescription)) {
        return;
    }
    [self sui_setAssociatedCopyObject:goodsActivityDescription key:GoodsActivityDescriptionKey];
}

- (NSString *)goodsActivityDescription {
    return [self sui_getAssociatedObjectWithKey:GoodsActivityDescriptionKey];
}

- (CGFloat)goodsActivityDescriptionHeight {
    NSString *goodsActivityDescription = [self sui_getAssociatedObjectWithKey:GoodsActivityDescriptionKey];
    if (isEmpty(goodsActivityDescription)) {
        return 0;
    }else {
        CGFloat activityDescriptionHeight = [goodsActivityDescription getSizeWithSize:CGSizeMake(kScreenWidth-57, 30) font:kSystemFontSize(12)].height;
        return activityDescriptionHeight + 10 * 2 + 5;
    }
}

@end

const void *GoodsAsGiftKey = @"GoodsAsGiftKey";

@implementation GoodsModel (goodsAsGift)

- (void)setIsAsGift:(BOOL)isAsGift {
    [self sui_setAssociatedAssignObject:@(isAsGift) key:GoodsAsGiftKey];
}

- (BOOL)isAsGift {
    return [[self sui_getAssociatedObjectWithKey:GoodsAsGiftKey] boolValue];
}

+ (NSArray *)objectGiftGoodsModelWithGoodsArr:(NSArray *)goodsArr {
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:goodsArr.count];
    for (NSDictionary *dic in goodsArr) {
        GoodsModel *model = [[GoodsModel alloc] init];
        model.goodsName = dic[@"saleProductName"];
        model.goodsOrderPrice = @([dic[@"orderPrice"] floatValue]/1000);
        model.goodsNumber = dic[@"cartNum"];
        model.goodsBrandName = dic[@"brandName"];
        model.isAsGift = YES;
        [tempArr addObject:model];
    }
    return [tempArr copy];
}


@end






