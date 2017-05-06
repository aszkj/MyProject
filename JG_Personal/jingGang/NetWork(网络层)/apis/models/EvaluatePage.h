//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface EvaluatePage : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//描述相符评价 对卖家描述相符评价
	@property (nonatomic, readonly, copy) NSNumber *descriptionEvaluate;
	//买家评价  买家评价，评价类型，1为好评，0为中评，-1为差评 
	@property (nonatomic, readonly, copy) NSNumber *evaluateBuyerVal;
	//晒单图片
	@property (nonatomic, readonly, copy) NSString *evaluatePhotos;
	//评价状态  0为正常，1为禁止显示，2为取消评价
	@property (nonatomic, readonly, copy) NSNumber *evaluateStatus;
	//购买的数量
	@property (nonatomic, readonly, copy) NSNumber *goodsNum;
	//服务态度评价 对卖家服务态度评价
	@property (nonatomic, readonly, copy) NSNumber *serviceEvaluate;
	//发货速度评价  对卖家发货速度评价
	@property (nonatomic, readonly, copy) NSNumber *shipEvaluate;
	//对应的订单
	@property (nonatomic, readonly, copy) NSNumber *ofId;
	//评价回复状态 0为未回复，1为已回复
	@property (nonatomic, readonly, copy) NSNumber *replyStatus;
	//addevaStatus
	@property (nonatomic, readonly, copy) NSNumber *addevaStatus;
	//addevaTime
	@property (nonatomic, readonly, copy) NSDate *追评时间;
	//管理员操作备注
	@property (nonatomic, readonly, copy) NSString *evaluateAdminInfo;
	//买家评价信息
	@property (nonatomic, readonly, copy) NSString *evaluateInfo;
	//评价回复
	@property (nonatomic, readonly, copy) NSString *reply;
	//addevaInfo
	@property (nonatomic, readonly, copy) NSString *addevaInfo;
	//addevaPhotos
	@property (nonatomic, readonly, copy) NSString *addevaPhotos;
	//买家昵称
	@property (nonatomic, readonly, copy) NSString *nickName;
	//商品名称
	@property (nonatomic, readonly, copy) NSString *goodsName;
	//商品店铺
	@property (nonatomic, readonly, copy) NSString *storeName;
	//商品属性值 
	@property (nonatomic, readonly, copy) NSString *goodsSpec;
	//商品主图
	@property (nonatomic, readonly, copy) NSString *goodsMainPhotoPath;
	//评论时间
	@property (nonatomic, readonly, copy) NSDate *addTime;
	
@end
