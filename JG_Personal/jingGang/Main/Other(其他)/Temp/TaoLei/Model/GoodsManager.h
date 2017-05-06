//
//  GoodsManager.h
//  jingGang
//
//  Created by thinker on 15/8/24.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopManager.h"

@interface GoodsManager : ShopManager

@property (nonatomic,copy) NSString *goodsMainPhotoPath;
@property (nonatomic) NSNumber *goodsCurrentPrice;
@property (nonatomic) Boolean hasMobilePrice;
@property (nonatomic) NSNumber *mobilePrice;
@property (nonatomic,copy) NSString *goodsName;
@property (nonatomic) NSNumber *goodscount;
@property (nonatomic,copy) NSString *goodsSpecInfo;
@property (nonatomic,copy) NSNumber *needChangeIntegral;
@property (nonatomic) BOOL isSelectedIntegral;
@property (nonatomic) NSNumber *integralPrice;
@property (nonatomic) NSNumber *exchangeIntegral;
@property (nonatomic) NSString *jifengDescrition;
@property (nonatomic) NSNumber *gcId;


- (id)initWithGoodsInfo:(NSDictionary *)goodsCart;

@end
