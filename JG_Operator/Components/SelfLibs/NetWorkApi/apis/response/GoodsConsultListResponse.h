//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "GoodsConsult.h"
#import "Goods.h"
#import "ShopEvaluate.h"

@interface GoodsConsultListResponse :  AbstractResponse
//商品详情
@property (nonatomic, readonly, copy) Goods *goodsDetails;
//商品评价列表
@property (nonatomic, readonly, copy) NSArray *shopEvaluateList;
//商品咨询列表
@property (nonatomic, readonly, copy) NSArray *goodsConsultList;
//总记录数
@property (nonatomic, readonly, copy) NSNumber *totalSize;
@end
