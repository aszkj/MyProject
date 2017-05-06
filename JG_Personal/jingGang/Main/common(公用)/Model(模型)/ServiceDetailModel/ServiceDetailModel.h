//
//  ServiceDetailModel.h
//  jingGang
//
//  Created by 张康健 on 15/9/22.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "BaseModel.h"

@interface ServiceDetailModel : BaseModel
//id
@property (nonatomic,  copy) NSNumber *ServiceDetailModelID;
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
//开始时间
@property (nonatomic,  copy) NSDate *beginTime;
//结束时间
@property (nonatomic,  copy) NSDate *endTime;
//已经售出的数量
@property (nonatomic,  copy) NSNumber *selledCount;
//购买须知
@property (nonatomic,  copy) NSString *groupNotice;
//消费用户昵称
@property (nonatomic,  copy) NSString *nickName;
//消费用户手机
@property (nonatomic,  copy) NSString *mobile;
//消费码
@property (nonatomic,  copy) NSString *groupSn;
//券消费状态|默认为0，使用后为1，过期为-1
@property (nonatomic,  copy) NSNumber *status;
//店铺名称
@property (nonatomic,  copy) NSString *storeName;
//店铺地址
@property (nonatomic,  copy) NSString *storeAddress;
//猜你喜欢列表
@property (nonatomic,  copy) NSArray *likeGoodsList;
//距离
@property (nonatomic,  copy) NSNumber *distance;
//公司电话
@property (nonatomic,  copy) NSString *licenseCTelephone;
//纬度
@property (nonatomic,  copy) NSNumber *storeLat;
//经度
@property (nonatomic,  copy) NSNumber *storeLon;


@property (nonatomic, copy) NSString *storeTelephone;


@property (nonatomic, copy) NSNumber *storeId;
@end
