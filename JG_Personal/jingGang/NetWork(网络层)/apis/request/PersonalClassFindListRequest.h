//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PersonalClassFindListResponse.h"

@interface PersonalClassFindListRequest : AbstractRequest
/** 
 * 分类id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_classId;
/** 
 * 城市id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_cityId;
/** 
 * 地区id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_areaId;
/** 
 * 距离|米
 */
@property (nonatomic, readwrite, copy) NSNumber *api_distance;
/** 
 * 智能排序类型|1距离2好评3智能
 */
@property (nonatomic, readwrite, copy) NSNumber *api_orderType;
/** 
 * 纬度
 */
@property (nonatomic, readwrite, copy) NSNumber *api_storeLat;
/** 
 * 经度
 */
@property (nonatomic, readwrite, copy) NSNumber *api_storeLon;
/** 
 * 每页记录数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/** 
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;
@end
