//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "GroupGoods.h"

@interface GroupGoods : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//商品名称
	@property (nonatomic, readonly, copy) NSString *ggName;
	//原价
	@property (nonatomic, readonly, copy) NSNumber *costPrice;
	//团购折扣
	@property (nonatomic, readonly, copy) NSNumber *ggRebate;
	//团队价 
	@property (nonatomic, readonly, copy) NSNumber *groupPrice;
	//商品状态 |  0为上架，1为在仓库中，3为店铺过期自动下架，-2为违规下架状态
	@property (nonatomic, readonly, copy) NSNumber *ggStatus;
	//团购图片
	@property (nonatomic, readonly, copy) NSString *groupAccPath;
	//服务描述
	@property (nonatomic, readonly, copy) NSString *groupDesc;
	//开始时间
	@property (nonatomic, readonly, copy) NSDate *beginTime;
	//结束时间
	@property (nonatomic, readonly, copy) NSDate *endTime;
	//已经售出的数量
	@property (nonatomic, readonly, copy) NSNumber *selledCount;
	//购买须知
	@property (nonatomic, readonly, copy) NSString *groupNotice;
	//消费用户昵称
	@property (nonatomic, readonly, copy) NSString *nickName;
	//消费用户手机
	@property (nonatomic, readonly, copy) NSString *mobile;
	//消费码
	@property (nonatomic, readonly, copy) NSString *groupSn;
	//券消费状态|默认为0，使用后为1，过期为-1
	@property (nonatomic, readonly, copy) NSNumber *status;
	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	//店铺地址
	@property (nonatomic, readonly, copy) NSString *storeAddress;
	//猜你喜欢列表
	@property (nonatomic, readonly, copy) NSArray *likeGoodsList;
	//距离
	@property (nonatomic, readonly, copy) NSNumber *distance;
	//公司电话
	@property (nonatomic, readonly, copy) NSString *licenseCTelephone;
	//纬度
	@property (nonatomic, readonly, copy) NSNumber *storeLat;
	//经度
	@property (nonatomic, readonly, copy) NSNumber *storeLon;
	
@end
