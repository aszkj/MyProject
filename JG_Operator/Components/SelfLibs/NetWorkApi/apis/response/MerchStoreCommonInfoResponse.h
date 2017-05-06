//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "StoreCommonInfo.h"
#import "Goods.h"

@interface MerchStoreCommonInfoResponse :  AbstractResponse
//商品列表
@property (nonatomic, readonly, copy) NSArray *goodsList;
//店铺商品分类
@property (nonatomic, readonly, copy) NSArray *storeInfo;
@end
