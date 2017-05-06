//
//  AwareStoreModel.h
//  jingGang
//
//  Created by 张康健 on 15/9/22.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "BaseModel.h"

@interface AwareStoreModel : BaseModel

//id
@property (nonatomic,  copy) NSNumber *AwareStoreModelID;
//店铺名称
@property (nonatomic,  copy) NSString *storeName;
//距离|米
@property (nonatomic,  copy) NSNumber *distance;
//服务名称
@property (nonatomic,  copy) NSString *goodsName;
//服务图片
@property (nonatomic,  copy) NSString *goodsPath;
//价格
@property (nonatomic,  copy) NSNumber *price;
//销量
@property (nonatomic,  copy) NSNumber *sales;
//服务id
@property (nonatomic,  copy) NSNumber *goodsId;


@end
