//
//  ServiceModel.h
//  jingGang
//
//  Created by 张康健 on 15/9/21.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "BaseModel.h"

@interface ServiceModel : BaseModel

//id
@property (nonatomic,  copy) NSNumber *ServiceModelID;
//商品名称
@property (nonatomic,  copy) NSString *ggName;
//原价
@property (nonatomic,  copy) NSNumber *costPrice;
//团购折扣
@property (nonatomic,  copy) NSNumber *ggRebate;
//团队价
@property (nonatomic,  copy) NSNumber *groupPrice;
//商品状态 |  0为上架，1为在仓库中，3为店铺过期自动下架，-2为违规下架状态
@property (nonatomic,  copy) NSNumber *ggStatus;
//团购图片
@property (nonatomic,  copy) NSString *groupAccPath;
//服务描述
@property (nonatomic,  copy) NSString *groupDesc;
//店铺名称
@property (nonatomic,  copy) NSString *storeName;
//距离
@property (nonatomic,  copy) NSNumber *distance;
//店铺id
@property (nonatomic,  copy) NSNumber *storeId;
//服务评分
@property (nonatomic,  copy) NSNumber *evaluationAverage;
//已经售出的数量
@property (nonatomic,  copy) NSNumber *selledCount;

@end
