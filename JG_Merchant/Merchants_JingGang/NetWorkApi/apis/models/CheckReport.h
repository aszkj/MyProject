//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "ResultDetails.h"

@interface CheckReport : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//报告名称
	@property (nonatomic, readonly, copy) NSString *resultname;
	//用户id
	@property (nonatomic, readonly, copy) NSString *createby;
	//体检时间
	@property (nonatomic, readonly, copy) NSDate *createtime;
	//机构/医院
	@property (nonatomic, readonly, copy) NSString *hospital;
	//体检报告状态：1未提交、2待处理、3已处理
	@property (nonatomic, readonly, copy) NSNumber *status;
	//处理结果
	@property (nonatomic, readonly, copy) NSString *result;
	//正常项
	@property (nonatomic, readonly, copy) NSNumber *rightCount;
	//正常项
	@property (nonatomic, readonly, copy) NSNumber *wrongCount;
	//体检项列表
	@property (nonatomic, readonly, copy) NSArray *detailsList;
	//体检时间
	@property (nonatomic, readonly, copy) NSDate *checkTime;
	
@end
