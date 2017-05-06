//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ShopEvaluate : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//addTime
	@property (nonatomic, readonly, copy) NSDate *addTime;
	//描述相符评价 对卖家描述相符评价
	@property (nonatomic, readonly, copy) NSNumber *descriptionEvaluate;
	//买家评价  买家评价，评价类型，1为好评，0为中评，-1为差评
	@property (nonatomic, readonly, copy) NSNumber *evaluateBuyerVal;
	//晒单图片
	@property (nonatomic, readonly, copy) NSString *evaluatePhotos;
	//评价状态  0为正常，1为禁止显示，2为取消评价
	@property (nonatomic, readonly, copy) NSNumber *evaluateStatus;
	//成交时的价格
	@property (nonatomic, readonly, copy) NSString *goodsPrice;
	//id
	@property (nonatomic, readonly, copy) NSNumber *serviceEvaluate;
	//发货速度评价  对卖家发货速度评价
	@property (nonatomic, readonly, copy) NSNumber *shipEvaluate;
	//评价时间
	@property (nonatomic, readonly, copy) NSDate *addevaTime;
	//管理员操作备注
	@property (nonatomic, readonly, copy) NSString *evaluateAdminInfo;
	//买家评价信息
	@property (nonatomic, readonly, copy) NSString *evaluateInfo;
	//商品属性值
	@property (nonatomic, readonly, copy) NSString *goodsSpec;
	//评价回复
	@property (nonatomic, readonly, copy) NSString *reply;
	//id
	@property (nonatomic, readonly, copy) NSString *addevaInfo;
	//
	@property (nonatomic, readonly, copy) NSString *addevaPhotos;
	//买家昵称
	@property (nonatomic, readonly, copy) NSString *nickName;
	//商品名称
	@property (nonatomic, readonly, copy) NSString *goodsName;
	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	//头像
	@property (nonatomic, readonly, copy) NSString *headImgPath;
	
@end
