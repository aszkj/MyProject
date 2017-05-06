//
//  GoodsInfoModel.h
//  jingGang
//
//  Created by 张康健 on 15/8/15.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "BaseModel.h"

@interface GoodsInfoModel : BaseModel
//商品价格
@property (nonatomic,  copy) NSString *goodsPrice;
//商品快照
@property (nonatomic,  copy) NSString *goodsSnapshoot;
//商品规格
@property (nonatomic,  copy) NSString *goodsGspVal;
//商品总价
@property (nonatomic,  copy) NSString *goodsAllPrice;
//商品id
@property (nonatomic,  copy) NSString *goodsId;
//商品类型
@property (nonatomic,  copy) NSString *goodsType;
//商品名称
@property (nonatomic,  copy) NSString *goodsName;
//商品主图
@property (nonatomic,  copy) NSString *goodsDomainPath;
//商品是否实体  0实体商品，1为虚拟商品
@property (nonatomic,  copy) NSString *goodsChoiceType;
//商品主图片
@property (nonatomic,  copy) NSString *goodsMainphotoPath;
//goodsGspIds
@property (nonatomic,  copy) NSString *goodsGspIds;
//goodsPayoffPrice
@property (nonatomic,  copy) NSString *goodsPayoffPrice;
//goodsCommissionPrice
@property (nonatomic,  copy) NSString *goodsCommissionPrice;
//goodsCommissionRate
@property (nonatomic,  copy) NSString *goodsCommissionRate;
//storeDomainPath
@property (nonatomic,  copy) NSString *storeDomainPath;
//商品数量
@property (nonatomic,  copy) NSNumber *goodsCount;

@end
