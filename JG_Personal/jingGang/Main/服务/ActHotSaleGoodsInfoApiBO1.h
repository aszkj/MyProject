//
//  JGActivityShopModel.h
//  jingGang
//
//  Created by dengxf on 15/12/10.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  活动商品模型
 */
@interface ActHotSaleGoodsInfoApiBO1 : NSObject
/**
 * 商品id
 */
@property (assign, nonatomic) long shopId;

/**
 * 手机专享价
 */
@property (assign , nonatomic) CGFloat goodsMobilePrice;

/**
 * 商品当前价格
 */
@property (assign, nonatomic) CGFloat goodsCurrentPrice;

/**
 * 商品价格
 */
@property (assign, nonatomic) CGFloat goodsPrice;
/**
 * 活动促销商品广告名称
 */
@property (copy , nonatomic) NSString *adTitle;

/**
 * 商品广告图片地址
 */
@property (copy , nonatomic) NSString *adImgPath;


/**
 * 热销商品的销量
 */
@property (assign, nonatomic) CGFloat goodsSalenum;

/**
 * 热销商品的库存
 */
@property (assign, nonatomic) CGFloat goodsInventory;

- (instancetype)initWithDict:(NSDictionary *)dic;
@end
