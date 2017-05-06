//
//  RecommendStoreModel.h
//  jingGang
//
//  Created by 张康健 on 15/9/21.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "BaseModel.h"

@interface RecommendStoreModel : BaseModel
//id
@property (nonatomic,  copy) NSNumber *RecommendStoreModelID;
//店铺名称
@property (nonatomic,  copy) NSString *storeName;
//店铺详细地址
@property (nonatomic,  copy) NSString *storeAddress;
//地区
@property (nonatomic,  copy) NSString *area;
//星级
@property (nonatomic,  copy) NSNumber *star;
//距离
@property (nonatomic,  copy) NSNumber *distance;
//banner图片
@property (nonatomic,  copy) NSString *storeInfoPath;
//服务评分
@property (nonatomic,  copy) NSNumber *evaluationAverage;


@end
