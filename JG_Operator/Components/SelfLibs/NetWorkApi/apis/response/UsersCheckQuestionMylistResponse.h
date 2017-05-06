//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "CheckQuestion.h"

@interface UsersCheckQuestionMylistResponse :  AbstractResponse
//我的体检报告
@property (nonatomic, readonly, copy) NSArray *circle;
//帖子id
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
@end
