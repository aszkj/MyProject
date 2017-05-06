//
//  GoodsSquModel.h
//  jingGang
//
//  Created by 张康健 on 15/8/25.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "BaseModel.h"

@interface GoodsSquModel : BaseModel

//id
@property (nonatomic,  copy) NSString *GoodsSquModelID;
//积分价
@property (nonatomic,  copy) NSNumber *integralPrice;
//价格
@property (nonatomic,  copy) NSNumber *price;
//积分
@property (nonatomic,  copy) NSNumber *integralCount;
//数量
@property (nonatomic,  copy) NSNumber *count;
//手机专享价
@property (nonatomic,  copy) NSNumber *mobilePrice;

#pragma mark - 新增的经过计算的squ实际价格
@property (nonatomic, assign)NSNumber* actualPrice;

//判断有没有手机专享价，因为如果外面有的话，里面可能有，可能有，可能没有
@property BOOL hasMobilePrice;

//判断有没有积分兑换价
@property BOOL hasIntegralPrice;

//如果有积分兑换价的话，返回积分兑换价和积分字符串
@property (nonatomic, copy)NSString *integralAndIntegralPriceStr;

//选择商品squ字符串
@property (nonatomic, copy)NSString *selectGoodsSquStr;

@end
