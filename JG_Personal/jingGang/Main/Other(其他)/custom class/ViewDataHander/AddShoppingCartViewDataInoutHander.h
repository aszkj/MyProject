//
//  AddShoppingCartViewDataInoutHander.h
//  jingGang
//
//  Created by 张康健 on 15/8/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsDetailModel.h"
#import <UIKit/UIKit.h>

@class GoodsSquModel;
//加入购物车视图，数据逻辑处理者
@interface AddShoppingCartViewDataInoutHander : NSObject

-(id)initWithGoodsDetailModel:(GoodsDetailModel *)goodsDetailModel;

//需要的商品model
@property (nonatomic, strong)GoodsDetailModel *goodsDetailModel;

//规格与属性对应的的字典，，即每个规格下面有哪些属性,利用商品model生成
@property (nonatomic, strong)NSMutableDictionary *cationPropertyMutableDic;

//商品实际价格，因为可能有积分价，手机专享价之类的
@property (nonatomic, assign)CGFloat goodsActualPrice;

//商品squ找到之后的model
@property (nonatomic, strong)GoodsSquModel *goodsSquModel;

//经过squ比对之后的价格
@property (nonatomic, assign)CGFloat squPrice;

//选择的规格属性id数组
@property (nonatomic, copy)NSArray *selectedPropertyIdArr;

//选择的规格属性id字符串
@property (nonatomic, copy)NSString *selectedPropertyIdStr;

//选择的规格属性名字字符串，
@property (nonatomic, copy)NSString *selectedPropertyStr;


@end
