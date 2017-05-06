//
//  ShopCartViewModel.h
//  YilidiBuyer
//
//  Created by yld on 16/5/3.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseViewModel.h"

@class DLShopCartModel;
@class GoodsModel;
@class AdressModel;
@class StoreModel;
@interface ShopCartViewModel : BaseViewModel

/**
 *  购物车列表
 */
@property (nonatomic,strong)NSMutableArray<DLShopCartModel *> *shopCartList;
/**
 *  购物车总价
 */
@property (nonatomic,assign)CGFloat totalPrice;

/**
 *  店铺名称
 */
@property (nonatomic,copy)NSString *shopName;


@property (nonatomic,strong)StoreModel *shopCartStoreModel;


/**
 *  默认地址
 */
@property (nonatomic,strong)AdressModel *defaultAdressModel;

/**
 *  送达时间
 */
@property (nonatomic,copy)NSString *deliveryTime;
/**
 *  自提时间
 */
@property (nonatomic,copy)NSString *pickUpTimeNote;


/**
 *  购物车是否为空
 */
@property (nonatomic,assign)BOOL shopCartIsEmpty;
/**
 *  是否全选
 */
@property (nonatomic,assign)BOOL allSelected;
/**
 *  是否处于编辑状态
 */
@property (nonatomic,assign)BOOL isEditing;
/**
 *  选中的商品的goodsId拼接字符串goodsId x number 分号隔开
 */
@property (nonatomic,copy)NSString *selectedGoodsJonedIdStr;
/**
 *  选中的商品的cartId拼接字符串goodsId逗号隔开
 */
@property (nonatomic,copy)NSString *selectedGoodsJonedShopCartIdStr;

/**
 *  购物车总数量
 */
@property (nonatomic,assign)NSInteger shopCartTotalNumber;
/**
 *  选中商品总数量
 */
@property (nonatomic,assign)NSInteger selectedShopCartGoodsNumber;

/**
 *  选中的购物车商品
 */
@property (nonatomic,copy)NSArray *selectedGoodsArr;
/**
 *  获取将要刷新的indexPaths,
 */
@property (nonatomic,copy)NSArray *willFreshIndexPaths;


- (RACSignal *)trigerShopCartTotalNumberSignal;

/**
 *  请求购物车列表
 */
- (RACSignal *)trigerShopCartlistRequestSignal;

/**
 *  商品数量改变
 */
- (RACSignal *)trigerShopCartGoodsNumberChangeSignalWithParamGoodsModel:(GoodsModel *)goodsModel;

/**
 *  选中或者取消选中购物车商品
 */
- (RACSignal *)trigerSelectDeselctGoodsSignalWithParamGoods:(NSArray*)goods
                                                   selected:(BOOL)selected;
/**
 *  删除购物车商品
 */

- (RACSignal *)trigerDeleteGoodsSignalWithParamGoods:(NSArray*)deleteGoods;

/**
 *  全选或者取消全选
 */

- (RACSignal *)trigerAllSelectedDeselectedSignalWithParamSelected:(BOOL)setSelected;

/**
 *  清空购物车
 */
- (RACSignal *)trigerClearShopCartSinal;


@end
