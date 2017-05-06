//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "ShopLuceneResult.h"
#import "Search.h"

@interface SearchClassGoodsResponse :  AbstractResponse
//搜索的分类商品列表
@property (nonatomic, readonly, copy) Search *searchGoodsList;
//关键字搜索商品列表
@property (nonatomic, readonly, copy) NSArray *keywordGoodsList;
//热门关键字
@property (nonatomic, readonly, copy) NSArray *hotKey;
@end
