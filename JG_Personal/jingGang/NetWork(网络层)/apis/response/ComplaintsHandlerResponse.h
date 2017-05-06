//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "GroupComplaint.h"

@interface ComplaintsHandlerResponse :  AbstractResponse
//总记录
@property (nonatomic, readonly, copy) NSNumber *totalCount;
//投诉列表
@property (nonatomic, readonly, copy) NSArray *groupComplaintBOs;
//投诉详情
@property (nonatomic, readonly, copy) GroupComplaint *groupComplaintsBO;
//列表总页数
@property (nonatomic, readonly, copy) NSNumber *totalPage;
@end
