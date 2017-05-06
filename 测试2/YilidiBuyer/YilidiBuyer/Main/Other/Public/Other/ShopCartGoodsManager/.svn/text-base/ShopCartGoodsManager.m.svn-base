//
//  ShopCartGoodsManager.m
//  YilidiBuyer
//
//  Created by yld on 16/5/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsManager.h"
#import "ProjectRelativeKey.h"
#import "TMCache.h"
#import "ShopCartGoodsManager+loginOut.h"
#import "ShopCartGoodsManager+calculateShopCartPriceAndNumber.h"
#import "ShopCartGoodsManager+request.h"
#import "ShopCartGoodsManager+switchCommunity.h"
#import "GlobleConst.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NSArray+SUIAdditions.h"
#import "ShopCartGoodsManager+shopCartInfo.h"
#import "ShopCartGoodsManager+checkWhenAddingShopCart.h"
#import "ShopCartGoodsManager+notifyGoodsToUpdateShopCartGoodsNumberOnUI.h"
#import "ShopCartGoodsManager+goodsCache.h"
#import "ShopCartGoodsManager+ensureShopCartGoodsType.h"

static NSString *shopCartGoodsCacheKey = @"shopCartGoodsCacheKey";
static ShopCartGoodsManager *_shopCartGoodsManager = nil;

@interface ShopCartGoodsManager()

@end

@implementation ShopCartGoodsManager

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _shopCartGoodsManager = [[ShopCartGoodsManager alloc] init];
        
    });
    return _shopCartGoodsManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _initInfo];
        [self  initCache];
        [self initTotalPriceTotalNumber];
        [self initShopCartGoodsType];
        [self _registerNotification];
    }
    return self;
}


#pragma mark -------------------Private Method----------------------
- (void)_setNewGoodsNumber:(NSInteger)newGoodsNumber goodsModel:(GoodsModel *)cacheGoodsModel isAdd:(BOOL)isAdd{
    cacheGoodsModel.goodsNumber = @(newGoodsNumber);
    if (!newGoodsNumber) {
        [self.goodsShopCartDictionary removeObjectForKey:cacheGoodsModel.goodsId];
    }else {
        [self.goodsShopCartDictionary setObject:cacheGoodsModel forKey:cacheGoodsModel.goodsId];
    }
    
    [self notifyTheGoods:cacheGoodsModel added:isAdd toTheNewNumber:newGoodsNumber];
    [self requestAdjustShopCartGoodsDataOfGoodsId:cacheGoodsModel IsAdd:isAdd];

}

-(void)_initInfo {
    _goodsShopCartDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    @weakify(self);
    [RACObserve(self, shopCartGoodsNumber) subscribeNext:^(NSNumber * shopCartGoodsNumber) {
        @strongify(self);
        self.shopCartIsEmpty = !shopCartGoodsNumber.integerValue;
    }];
}

- (void)_registerNotification {
    
    [self registerLoginOutNotification];
    [self  registerSwitchCommunityNotification];
}

#pragma mark -------------------Public Method----------------------
#pragma mark - 加减商品workflow
/**
 *  如果是该商品是第一个商品，根据该商品的类型确定购物车的商品类型
 *  如果两个商品id相同，那么只有有一个商品存在活动id，那么后加的将之前存在的替换掉，数量和价格重新计算
 *  加减商品后，会影响总数量，也可能影响实际选中总数量总价格，所以加减后，1 计算总数量 2 计算实际选中总数量总价格
 *  重新设置该商品在购物车中的数量，如果是0的话，就将该商品id从购物车中移除
 *  通知其它商品列表上和该商品id相同的商品，更新他的购物车数量显示
 *  登录状态下，请求加减接口
 */
- (void)addShopCartGoodsWithGoodsModel:(GoodsModel *)goodsModel isInShopCartPage:(BOOL)isInShopCartPage{
    
    if (!self.shopCartGoodsNumber) {
        [self ensureShopCartGoodsTypeByTheFirstGoodsModel:goodsModel];
    }
    
    GoodsModel *cachedGoodsModel = self.goodsShopCartDictionary[goodsModel.goodsId];
    NSInteger newGoodsCount = 0;
    if (isEmpty(cachedGoodsModel)) {
        newGoodsCount = 1;
        self.shopCartGoodsNumber ++;
    }else {
        if ([self isRealTheSameGoodsComparingOutShopCartGoods:goodsModel withShopCartGoods:cachedGoodsModel]) {//是真的同一个商品
            newGoodsCount = cachedGoodsModel.goodsNumber.integerValue + 1;
            self.shopCartGoodsNumber ++;
        }else {//商品id相同，但是一个商品可能有活动，另一个没有，后加的替换前面已有的
            newGoodsCount = 1;
            //减去被替换的商品的数量和价格
            [self calculateNumberAndPriceForBeReplacedGoodsModel:cachedGoodsModel];
        }
    }
    if (!isInShopCartPage) {
        goodsModel.selected = YES;
    }

    [self calculateActuralSelectedShopCartGoodsTotalPriceAndNumberWhenAddSubGoodsModel:goodsModel isAdd:YES isInShopCartPage:isInShopCartPage];
    [self _setNewGoodsNumber:newGoodsCount goodsModel:goodsModel isAdd:YES];
}

- (void)subShopCartGoodsWithGoodsModel:(GoodsModel *)goodsModel isInShopCartPage:(BOOL)isInShopCartPage{
    
    GoodsModel *cachedGoodsModel = self.goodsShopCartDictionary[goodsModel.goodsId];
    if (isEmpty(cachedGoodsModel) ) {
        return;
    }
    self.shopCartGoodsNumber --;
    if (!isInShopCartPage) {
        goodsModel.selected = YES;
    }
    
    [self calculateActuralSelectedShopCartGoodsTotalPriceAndNumberWhenAddSubGoodsModel:goodsModel isAdd:NO isInShopCartPage:isInShopCartPage];
    NSInteger newGoodsNumber = cachedGoodsModel.goodsNumber.integerValue - 1;
    [self _setNewGoodsNumber:newGoodsNumber goodsModel:goodsModel isAdd:NO];
}
#pragma mark - 删除商品workflow
/**
 *  删除商品后，会影响总数量，也可能影响实际选中总数量总价格，所以加减后，1 计算总数量 2 计算实际选中总数量总价格
 *  通知其它商品列表上和这些删除的商品id相同的商品，更新他们的购物车数量显示
 *  登录状态下，请求删除商品接口
 *  从购物车字典中移除这些商品
 */
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
            if ([self isValidateCanbeBuyOfGoodsModel:deleteGoodsModel]) {
                deleSelectedGoodsTotalPrice += deleteGoodsModel.goodsOrderPrice.floatValue * deleteGoodsModel.goodsNumber.integerValue;
                deleteTotalSelectedGoodsNumber += deleteGoodsModel.goodsNumber.integerValue;
            }
        }
    }
    self.shopCartGoodsNumber -= deleteTotalGoodsNumber;
    self.selectedShopCartGoodsNumber -= deleteTotalSelectedGoodsNumber;
    self.totalPrice -= deleSelectedGoodsTotalPrice;
    
    [self postNotificationOfDeleteGoodsIds:goodsIds];
    [self requestDeleteShopCartGoodsForGoodsIds:goodsIds];
    [self.goodsShopCartDictionary removeObjectsForKeys:goodsIds];
}

#pragma mark - 选中商品workflow
/**
 *  选中商品后只会影响实际选中总数量总价格，所以加减后，1 计算实际选中总数量总价格
 */
- (void)selectDeselecteShopCartGoodsOfGoodsIds:(NSArray *)goodsIds
                                      selected:(BOOL)selected
{
  //是否选中只会影响价格，和选中商品总数量
    NSArray *willSelectedDeseletedGoodsArr = [self.goodsShopCartDictionary objectsForKeys:goodsIds notFoundMarker:@""];
    CGFloat   selectedDeleSelectedGoodsTotalPrice = 0.0;
    NSInteger selectedGoodsNumber = 0;
    for (GoodsModel *model in willSelectedDeseletedGoodsArr) {
        if (![self isValidateCanbeBuyOfGoodsModel:model]) {
            continue;
        }
        CGFloat detaPrice = model.goodsOrderPrice.floatValue * model.goodsNumber.integerValue;
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


- (void)clearProducedOrderGoods {
    
    [self deleteGoodsOfGoodsIds:[self selectedGoodsIdArr]];
    
}

- (void)clearAllShopCartData {
    
    [self postNotificationOfDeleteGoodsIds:self.allGoodsIds];
    [self.goodsShopCartDictionary removeAllObjects];
    self.shopCartGoodsNumber = 0;
    self.selectedShopCartGoodsNumber = 0;
    self.totalPrice = 0.0f;
    [self cleanShopCartCache];
}


#pragma mark -------------------Getter/Setter Method----------------------
@end
