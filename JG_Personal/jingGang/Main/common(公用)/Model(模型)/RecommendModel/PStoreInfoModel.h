//
//  PStoreInfoModel.h
//  jingGang
//
//  Created by 张康健 on 15/10/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface PStoreInfoModel : BaseModel
//id
@property (nonatomic,  copy) NSNumber *PStoreInfoModelID;
//店铺名称
@property (nonatomic,  copy) NSString *storeName;
//店铺详细地址
@property (nonatomic,  copy) NSString *storeAddress;
//店铺等级，根据好评数累加
@property (nonatomic,  copy) NSNumber *storeCredit;
//服务评分
@property (nonatomic,  copy) NSNumber *storeEvaluationAverage;
//店铺介绍
@property (nonatomic,  copy) NSString *storeInfo;
//图片
@property (nonatomic,  copy) NSString *photoPath;
//图片数量
@property (nonatomic,  copy) NSNumber *photoSize;
//距离
@property (nonatomic,  copy) NSNumber *distance;
//纬度
@property (nonatomic,  copy) NSNumber *storeLon;
//经度
@property (nonatomic,  copy) NSNumber *storeLat;
//店铺电话
@property (nonatomic,  copy) NSString *storeTelephone;
//公司简介
@property (nonatomic,  copy) NSString *licenseCDesc;


@end
