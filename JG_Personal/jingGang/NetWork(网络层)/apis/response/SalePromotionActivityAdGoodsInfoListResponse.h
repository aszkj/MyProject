//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "ActHotSaleGoodsInfoApiBO.h"

@interface SalePromotionActivityAdGoodsInfoListResponse :  AbstractResponse
//促销活动商品信息
@property (nonatomic, readonly, copy) NSArray *goodsList;
@end
