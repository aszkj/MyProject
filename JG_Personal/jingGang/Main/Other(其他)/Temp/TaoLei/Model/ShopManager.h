//
//  TLOrderManager.h
//  jingGang
//
//  Created by thinker on 15/8/24.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShopManager : NSObject

@property (nonatomic) NSString *shopName;
@property (nonatomic) NSString *seletedTransport;
@property (nonatomic) UIImage *shop_icon;
@property (nonatomic) NSNumber *totalPrice;
@property (nonatomic) NSInteger totalCount;
@property (nonatomic) double goodsRealPrice;
@property (nonatomic) double transportPrice;
@property (nonatomic) double youhuiVaule;
@property (nonatomic) long youhuiId;
@property (nonatomic) double jifengVaule;
//@property (nonatomic) NSString *feedBack;
@property (nonatomic) NSMutableArray *youhuiArray;

/**
 *  运输方式
 */
@property (nonatomic) NSArray *transportWay;
/**
 *  运输方式对应的价格
 */
@property (nonatomic) NSArray *transportMoney;

@property (nonatomic) NSMutableArray *goodsArray;

- (id)initWithShopStore:(NSDictionary *)shopStore;
- (void)getGoodsWithGoodsCartList:(NSArray *)goodsCartList;


@end




