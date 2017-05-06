//
//  ShopCartGoodsManager.m
//  YilidiBuyer
//
//  Created by yld on 16/5/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DispatchGoodsManager.h"
#import "ProjectRelativeKey.h"
#import "TMCache.h"
#import "ShopCartGoodsManager+loginOut.h"
#import "ShopCartGoodsManager+calculateShopCartPriceAndNumber.h"
#import "ShopCartGoodsManager+request.h"
#import "ShopCartGoodsManager+switchCommunity.h"
#import "GlobleConst.h"
#import "NSArray+SUIAdditions.h"

static NSString *shopCartGoodsCacheKey = @"shopCartGoodsCacheKey";

static DispatchGoodsManager *_shopCartGoodsManager = nil;

@interface DispatchGoodsManager()

@property (nonatomic,strong)TMCache *shopCartGoodsCache;

@property (nonatomic, copy)NSArray *selectedGoodsIdArr;


@end

@implementation DispatchGoodsManager

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _shopCartGoodsManager = [[DispatchGoodsManager alloc] init];
        
    });
    return _shopCartGoodsManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _initInfo];
        [self _initCache];
        [self _registerNotification];
    }
    return self;
}


#pragma mark -------------------Private Method----------------------
- (void)_setNewGoodsNumber:(NSInteger)newGoodsNumber goodsModel:(GoodsModel *)cacheGoodsModel isAdd:(BOOL)isAdd{
    cacheGoodsModel.goodsNumber = @(newGoodsNumber);
    if (newGoodsNumber <= 0) {
        [self.goodsShopCartDictionary removeObjectForKey:cacheGoodsModel.goodsId];
    }else {
        [self.goodsShopCartDictionary setObject:cacheGoodsModel forKey:cacheGoodsModel.goodsId];
    }
    NSDictionary *postDic = @{
                              KGoodsChangeGoodsNumberKey:@(newGoodsNumber),
                              KGoodsChangeIsAddKey:@(isAdd)};
    [kNotification postNotificationName:KGoodsIdNotificationNameWithGoodsId(cacheGoodsModel.goodsId) object:nil userInfo:postDic];
    if (SESSIONID) {
        [self requestAdjustShopCartGoodsDataOfGoodsId:cacheGoodsModel.goodsId IsAdd:isAdd];
    }
}

-(void)_initInfo {
    
    _goodsShopCartDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
}

- (void)_registerNotification {
    
    [self registerLoginOutNotification];
    [self  registerSwitchCommunityNotification];
}

-(void)_initCache {
    
    _shopCartGoodsCache = [TMCache sharedCache];
    NSDictionary *cachedGoodsDic = [_shopCartGoodsCache objectForKey:shopCartGoodsCacheKey];
    if (!isEmpty(cachedGoodsDic)) {
        [self.goodsShopCartDictionary addEntriesFromDictionary:cachedGoodsDic];
        [self initTotalPriceTotalNumber];
    }else {
        self.totalPrice = 0.0;
        self.shopCartGoodsNumber = 0;
    }
}

- (void)_postNotificationOfDeleteGoodsIds:(NSArray *)deleteGoodsIds {
    for (NSString *goodsId in deleteGoodsIds) {
        NSDictionary *postDic = @{
                                  KGoodsChangeGoodsNumberKey:@(0),
                                  KGoodsChangeIsAddKey:@(NO)};
        [kNotification postNotificationName:KGoodsIdNotificationNameWithGoodsId(goodsId) object:nil userInfo:postDic];
    }
}


#pragma mark -------------------Public Method----------------------
- (void)addShopCartGoodsWithGoodsModel:(GoodsModel *)goodsModel isInShopCartPage:(BOOL)isInShopCartPage{
    GoodsModel *cachedGoodsModel = self.goodsShopCartDictionary[goodsModel.goodsId];
    NSInteger newGoodsCount = 0;
    if (isEmpty(cachedGoodsModel)) {
        newGoodsCount = goodsModel.basicOrderNumber.integerValue;
    }else {
        newGoodsCount = cachedGoodsModel.goodsNumber.integerValue + goodsModel.basicOrderNumber.integerValue;
    }
    self.shopCartGoodsNumber += goodsModel.basicOrderNumber.integerValue;
    if (!isInShopCartPage) {
        goodsModel.selected = YES;
    }
    
    [self calculatePriceAndSelectedTotalGoodsNumberWhenAddSubGoodsModel:goodsModel isAdd:YES];
    [self _setNewGoodsNumber:newGoodsCount goodsModel:goodsModel isAdd:YES];
}

- (void)subShopCartGoodsWithGoodsModel:(GoodsModel *)goodsModel isInShopCartPage:(BOOL)isInShopCartPage{
    
    GoodsModel *cachedGoodsModel = self.goodsShopCartDictionary[goodsModel.goodsId];
    if (isEmpty(cachedGoodsModel) ) {
        return;
    }
    self.shopCartGoodsNumber -= goodsModel.basicOrderNumber.integerValue;
    if (!isInShopCartPage) {
        goodsModel.selected = YES;
    }
    
    [self calculatePriceAndSelectedTotalGoodsNumberWhenAddSubGoodsModel:goodsModel isAdd:NO];
    NSInteger newGoodsNumber = cachedGoodsModel.goodsNumber.integerValue - goodsModel.basicOrderNumber.integerValue;
    [self _setNewGoodsNumber:newGoodsNumber goodsModel:goodsModel isAdd:NO];
}

- (NSInteger)goodsNumberOfGoodsId:(NSString *)goodsId{
   GoodsModel *cachedGoodsModel = self.goodsShopCartDictionary[goodsId];
    if (isEmpty(cachedGoodsModel)) {
        return 0;
    }
    return cachedGoodsModel.goodsNumber.integerValue;
}

- (void)deleteGoodsOfGoodsIds:(NSArray *)goodsIds {
    NSAssert(goodsIds.count > 0, @"删除的商品数量不能为0");
    //删除会影响数量和价格
    NSArray *willDeleteGoodsArr = [self.goodsShopCartDictionary objectsForKeys:goodsIds notFoundMarker:@"noKey"];
    if (willDeleteGoodsArr.count == 1) {
        //没有找到对应商品
        if (![willDeleteGoodsArr.firstObject isMemberOfClass:[GoodsModel class]]) {
            return;
        }
    }
    NSInteger deleteTotalGoodsNumber = 0;
    NSInteger deleteTotalSelectedGoodsNumber = 0;
    CGFloat   deleSelectedGoodsTotalPrice = 0.0;
    for (GoodsModel *deleteGoodsModel in willDeleteGoodsArr) {
        deleteTotalGoodsNumber += deleteGoodsModel.goodsNumber.integerValue;
        if (deleteGoodsModel.selected) {//删除选中的
//            if (deleteGoodsModel.goodsOnShelf.integerValue) {
                deleSelectedGoodsTotalPrice += deleteGoodsModel.goodsPurchasePrice.floatValue * deleteGoodsModel.goodsNumber.integerValue;
                deleteTotalSelectedGoodsNumber += deleteGoodsModel.goodsNumber.integerValue;
//            }
        }
    }
    self.shopCartGoodsNumber -= deleteTotalGoodsNumber;
    self.selectedShopCartGoodsNumber -= deleteTotalSelectedGoodsNumber;
    self.totalPrice -= deleSelectedGoodsTotalPrice;
    [self _postNotificationOfDeleteGoodsIds:goodsIds];
    [self.goodsShopCartDictionary removeObjectsForKeys:goodsIds];
}

- (void)selectDeselecteShopCartGoodsOfGoodsIds:(NSArray *)goodsIds
                                      selected:(BOOL)selected
{
  //是否选中只会影响价格，和选中商品总数量
    NSArray *willSelectedDeseletedGoodsArr = [self.goodsShopCartDictionary objectsForKeys:goodsIds notFoundMarker:@""];
    CGFloat   selectedDeleSelectedGoodsTotalPrice = 0.0;
    NSInteger selectedGoodsNumber = 0;
    for (GoodsModel *model in willSelectedDeseletedGoodsArr) {
//        if (!model.goodsOnShelf.integerValue) {
//            continue;
//        }
        CGFloat detaPrice = model.goodsPurchasePrice.floatValue * model.goodsNumber.integerValue;
        if (selected) {
            selectedDeleSelectedGoodsTotalPrice += detaPrice;
            selectedGoodsNumber += model.goodsNumber.integerValue;
        }else {
            selectedDeleSelectedGoodsTotalPrice -= detaPrice;
            selectedGoodsNumber -= model.goodsNumber.integerValue;

        }
        model.selected = selected;
    }

    self.totalPrice += selectedDeleSelectedGoodsTotalPrice;
    self.selectedShopCartGoodsNumber += selectedGoodsNumber;

}

- (void)selectDeselecteAllShopCartGoodsSelected:(BOOL)selected {
    self.totalPrice = 0.0f;
    self.selectedShopCartGoodsNumber = 0;
    if (!selected) {
        return;
    }
    [self selectDeselecteShopCartGoodsOfGoodsIds:self.goodsShopCartDictionary.allKeys selected:selected];
}


- (void)doShopCartCache {
    [self.shopCartGoodsCache setObject:self.goodsShopCartDictionary forKey:shopCartGoodsCacheKey];
}

- (void)clearProducedOrderGoods {
    
    [self deleteGoodsOfGoodsIds:self.selectedGoodsIdArr];
}

- (void)cleanShopCartCache {
    [self.shopCartGoodsCache setObject:nil forKey:shopCartGoodsCacheKey];
    [self.shopCartGoodsCache removeObjectForKey:shopCartGoodsCacheKey];

}

- (void)clearAllShopCartData {
    
    [self.goodsShopCartDictionary removeAllObjects];
    self.shopCartGoodsNumber = 0;
    self.selectedShopCartGoodsNumber = 0;
    self.totalPrice = 0.0f;
    [self cleanShopCartCache];
}


#pragma mark -------------------Getter/Setter Method----------------------
- (NSArray *)allShopCartGoods {
    return self.goodsShopCartDictionary.allValues;
}

- (NSArray *)allGoodsIds {

    return [self.allShopCartGoods sui_map:^NSString *(GoodsModel* goodsModel, NSUInteger index) {
        return goodsModel.goodsId;
    }];
}


- (NSArray *)allGoodsIdToNumberArr{
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:self.goodsShopCartDictionary.count];
    [self.goodsShopCartDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        GoodsModel *goodsModel = (GoodsModel *)obj;
        NSString *goodsId = (NSString *)key;
        NSDictionary *tempDic = @{@"saleProductId":goodsId,
                                  @"allotNum":goodsModel.goodsNumber};
        [tempArr addObject:tempDic];
    }];
    
    return [tempArr copy];
}

- (NSArray *)selectedGoodsIdToNumberArr {
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:self.goodsShopCartDictionary.count];
    NSMutableArray *tempSelectedIdArrs = [NSMutableArray arrayWithCapacity:self.goodsShopCartDictionary.count];
    [self.goodsShopCartDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        GoodsModel *goodsModel = (GoodsModel *)obj;
        NSString *goodsId = (NSString *)key;
        if (goodsModel.selected) {
//            if (goodsModel.goodsOnShelf.integerValue) {
                NSDictionary *tempDic = @{@"saleProductId":goodsId,
                                          @"allotNum":goodsModel.goodsNumber};
                [tempArr addObject:tempDic];
                [tempSelectedIdArrs addObject:goodsId];
//            }
        }
    }];
    self.selectedGoodsIdArr = [tempSelectedIdArrs copy];
    return [tempArr copy];
}

@end
