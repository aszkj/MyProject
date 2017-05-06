//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PersonalKeywordSearchResponse.h"

@interface PersonalKeywordSearchRequest : AbstractRequest
/** 
 * 城市id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_cityId;
/** 
 * 关键字
 */
@property (nonatomic, readwrite, copy) NSString *api_keyWord;
/** 
 * 地区id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_areaId;
/** 
 * 距离|米
 */
@property (nonatomic, readwrite, copy) NSNumber *api_distance;
/** 
 * 智能排序类型
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
