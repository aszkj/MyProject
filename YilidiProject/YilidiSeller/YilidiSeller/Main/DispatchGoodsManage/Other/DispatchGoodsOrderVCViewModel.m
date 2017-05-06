//
//  ShopCartViewModel.m
//  YilidiBuyer
//
//  Created by yld on 16/5/3.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DispatchGoodsOrderVCViewModel.h"
#import "NSObject+setModelIndexPath.h"
#import "GlobleConst.h"
#import "ShopCartGoodsManager+updateShopCart.h"
#import "DispatchGoodsManager.h"

@interface DispatchGoodsOrderVCViewModel()

@property (nonatomic,strong)DispatchGoodsManager *shopCartManager;

@end

@implementation DispatchGoodsOrderVCViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isEditing = NO;
        RAC(self,totalPrice) = RACObserve(self.shopCartManager, totalPrice);
        self.shopCartTotalNumber = self.shopCartManager.shopCartGoodsNumber;
        RAC(self,shopCartTotalNumber) = RACObserve(self.shopCartManager, shopCartGoodsNumber);
        RAC(self,selectedShopCartGoodsNumber) = RACObserve(self.shopCartManager, selectedShopCartGoodsNumber);
        RAC(self,shopCartIsEmpty) = [RACObserve(self, shopCartTotalNumber) map:^NSNumber*(NSNumber *shopCartNumber) {
            return @(!shopCartNumber.integerValue);
        }];
    }
    return self;
}

#pragma mark -------------------Private Method----------------------
/**
 *  选中取消选中商品
 */
- (void)_setGoodsModels:(NSArray *)goods seleted:(BOOL)selected{
    
    for (GoodsModel *selecteDeselctModel in goods) {
        for (GoodsModel *shopCartModel in self.shopCartList) {
            if ([selecteDeselctModel.goodsId isEqualToString:shopCartModel.goodsId]) {
                shopCartModel.selected = selected;
            }
        }
    }
}

/**
 *检查是否都选中了
 */
-(BOOL)_checkAllGoodsSelected {
    
    for (GoodsModel *model in self.shopCartList) {
        if (!model.selected) {
            return NO;
        }
    }
    return YES;
}

-(void)_selectDeselctGoodsSignalWithParamGoods:(NSArray*)goods
                                     selected:(BOOL)selected
                                   isAllGoods:(BOOL)isAllGoods
{
    
    [self _setGoodsModels:goods seleted:selected];
    
    [self _dealWheatherAllSelectedWithSelectedDeselectedGoods:goods selected:selected];
    
    [self _setWillRreshIndexPathsByArr:goods];
    
    NSArray *selectedDeselectedGoodIdsArr = [goods sui_map:^NSString *(GoodsModel* goodsModel, NSUInteger index) {
        return goodsModel.goodsId;
    }];
    if (isAllGoods) {
        [self.shopCartManager selectDeselecteAllShopCartGoodsSelected:selected];
    }else {
        [self.shopCartManager selectDeselecteShopCartGoodsOfGoodsIds:selectedDeselectedGoodIdsArr selected:selected];
    }

}



- (void)_dealWheatherAllSelectedWithSelectedDeselectedGoods:(NSArray *)goods selected:(BOOL)selected{
    if (goods.count > 1) {
        self.allSelected = [self _checkAllGoodsSelected];
    }else {
        if (goods.count == 1) {
            GoodsModel *model = goods.firstObject;
            if (self.shopCartList.count == 1) {
                self.allSelected = model.selected;
            }else {
                if (!model.selected) {
                    self.allSelected = model.selected;
                }else {
                    self.allSelected = [self _checkAllGoodsSelected];
                }
            }
        }
    }
}

-(void)_setWillRreshIndexPathsByArr:(NSArray *)willFreshGoods {
    
    NSArray *willFreshIndexPaths = [willFreshGoods sui_map:^NSIndexPath *(GoodsModel* model, NSUInteger index) {
        return [NSIndexPath indexPathForRow:model.modelAtIndexPath.row inSection:0];
    }];
    self.willFreshIndexPaths = willFreshIndexPaths;
}




#pragma mark -------------------Getter/Setter Method----------------------
-(DispatchGoodsManager *)shopCartManager {
    
    if (!_shopCartManager) {
        _shopCartManager = [DispatchGoodsManager sharedManager];
    }
    return _shopCartManager;
}


- (void)setShopCartTotalNumber:(NSInteger)shopCartTotalNumber {
    
    self.shopCartIsEmpty = !shopCartTotalNumber;
    if (_shopCartTotalNumber != shopCartTotalNumber || !shopCartTotalNumber) {
        _shopCartTotalNumber = shopCartTotalNumber;
    }
}

#pragma mark -------------------Function Method----------------------
- (RACSignal *)trigerShopCartlistRequestSignal {
    
//    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithCapacity:0];
//    NSArray *shopCartGoods = [ShopCartGoodsManager sharedManager].allGoodsIdToNumberArr;
//    if (shopCartGoods.count >0) {
//        [requestParam setObject:shopCartGoods forKey:@"cartInfo"];
//    }else {
//        self.shopCartIsEmpty = YES;
////        return nil;
//    }
//    if (kCommunityId) {
//        [requestParam setObject:kCommunityId forKey:@"communityId"];
//    }else {
//        [requestParam setObject:kDefaultCommunityId forKey:@"communityId"];
//    }
//    @weakify(self);
//   return [AFNHttpRequestOPManager rac_PostWithSubUrl:kUrl_ConfirmShopCartData parameters:requestParam subScribeResultBlock:^RACDisposable *(id result, NSError *error, id<RACSubscriber> subscriber) {
//       @strongify(self);
//        NSArray *shopCartList = result[EntityKey][@"shopCartList"];
//       NSDictionary *shopCartDic = shopCartList.firstObject;
//       NSArray *shopCartGoodsArr = shopCartDic[@"saleProductList"];
//       self.shopName = shopCartDic[@"storeName"];
//       NSArray *transFeredArr = [shopCartGoodsArr sui_map:^GoodsModel *(NSDictionary* obj, NSUInteger index) {
//           GoodsModel *model = [[GoodsModel alloc] initWithDefaultDataDic:obj];
//           model.goodsNumber = obj[@"cartNum"];
//            return model;
//       }];
//
//       [[ShopCartGoodsManager sharedManager] updateShopCartGoodsDicWithGoodsArr:transFeredArr isSychronizeShopCart:NO];
//        [subscriber sendNext:[self.shopCartManager allShopCartGoods]];
//        [subscriber sendCompleted];
//
//        return nil;
//    }];
    RACSubject *subject = [RACSubject subject];
    afterSecondsLoadData(0.3,
                         [subject sendNext:[self.shopCartManager allShopCartGoods]];
                         [subject sendCompleted];
                         
                         )
  
   
    
    return subject;

}

- (RACSignal *)trigerSelectDeselctGoodsSignalWithParamGoods:(NSArray*)goods
                                                   selected:(BOOL)selected
{
    RACSubject *selectSubject = [RACSubject subject];
   
    [self _selectDeselctGoodsSignalWithParamGoods:goods selected:selected isAllGoods:NO];
    
    return selectSubject;
}

- (RACSignal *)trigerDeleteGoodsSignalWithParamGoods:(NSArray*)deleteGoods {
    
    NSAssert(deleteGoods.count>0, @"delete goods can not small than 0");
    NSMutableArray *delelteGoodsIds = [NSMutableArray arrayWithCapacity:deleteGoods.count];
    NSMutableIndexSet *deleteIndexSets = [[NSMutableIndexSet alloc] init];
    for (GoodsModel *selectedeleteModel in deleteGoods) {
        [delelteGoodsIds addObject:selectedeleteModel.goodsId];
        [deleteIndexSets addIndex:selectedeleteModel.modelAtIndexPath.row];
    }
    
    RACSubject *deleteGoodsSubject = [RACSubject subject];
    afterSecondsLoadData(0.1,
                         [self _setWillRreshIndexPathsByArr:deleteGoods];
                         [self.shopCartList removeObjectsAtIndexes:deleteIndexSets];
                         [self.shopCartList setIndexPathInselfContainer];
                         [self.shopCartManager deleteGoodsOfGoodsIds:(NSArray *)delelteGoodsIds];
                         [deleteGoodsSubject sendNext:@"success"];
                         [deleteGoodsSubject sendCompleted];
                         )
    return deleteGoodsSubject;
}

- (RACSignal *)trigerAllSelectedDeselectedSignalWithParamSelected:(BOOL)setSelected {
    RACSubject *selectSubject = [RACSubject subject];
    [self _selectDeselctGoodsSignalWithParamGoods:self.shopCartList selected:setSelected isAllGoods:YES];
    return selectSubject;
}

- (RACSignal *)trigerClearShopCartSinal {

    return [self trigerDeleteGoodsSignalWithParamGoods:self.shopCartList];
}


@end
