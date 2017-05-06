//
//  ShopCartGoodsManager.h
//  YilidiBuyer
//
//  Created by yld on 16/5/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"
#import "ProjectRelativEmerator.h"
@interface ShopCartGoodsManager : NSObject

+ (instancetype)sharedManager;
/**
 *  购物车商品类型
 */
@property (nonatomic,assign)GoodsType shopCartGoodsType;
/**
 *  加商品，是否在购物车，如果不在购物车，默认加了，就要加上这个商品的价格的，如果在购物车，加了，因为它有可能没有选中，所以可能不会计算价格
 */
- (void)addShopCartGoodsWithGoodsModel:(GoodsModel *)goodsModel isInShopCartPage:(BOOL)isInShopCartPage;
/**
 *  减商品,
 */
- (void)subShopCartGoodsWithGoodsModel:(GoodsModel *)goodsModel isInShopCartPage:(BOOL)isInShopCartPage;

/**
 *  购物车商品字典
 */
@property (nonatomic,strong)NSMutableDictionary *goodsShopCartDictionary;
/**
 *  获取购物车商品总数量
 */
@property (nonatomic,assign)NSInteger shopCartGoodsNumber;
/**
 *  购物车是否为空
 */
@property (nonatomic,assign)NSInteger shopCartIsEmpty;
/**
 *  选中商品总数量
 */
@property (nonatomic,assign)NSInteger selectedShopCartGoodsNumber;
/**
 *获取购物车选中的商品总价
 */
@property (nonatomic,assign)CGFloat totalPrice;

/**
 *  根据商品ID删除商品
 */
- (void)deleteGoodsOfGoodsIds:(NSArray *)goodsIds;
/**
 *  选中或取消选中商品
 *
 *  @param goodsIds 商品
 *  @param selected 是否选中
 */
- (void)selectDeselecteShopCartGoodsOfGoodsIds:(NSArray *)goodsIds
                                      selected:(BOOL)selected;
/**
 *  全选或取消全选购物车商品
 */
- (void)selectDeselecteAllShopCartGoodsSelected:(BOOL)selected;

/**
 *  清除生成订单的商品
 */
- (void)clearProducedOrderGoods;
/**
 *  清除所有购物车商品
 */
- (void)clearAllShopCartData;

@end
