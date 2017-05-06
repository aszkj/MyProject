//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "IntegralListByCriteriaResponse.h"

@interface IntegralListByCriteriaRequest : AbstractRequest
/** 
 * 是否查询所有(查询所有：true,否则false)
 */
@property (nonatomic, readwrite, copy) NSNumber *api_findAll;
/** 
 * 积分范围值查询--最小值
 */
@property (nonatomic, readwrite, copy) NSString *api_minIntegral;
/** 
 * 积分范围值查询--最大值
 */
@property (nonatomic, readwrite, copy) NSString *api_maxIntegral;
/** 
 * 每页记录数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/** 
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;
@end
