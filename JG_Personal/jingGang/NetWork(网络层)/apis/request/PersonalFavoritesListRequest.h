//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PersonalFavoritesListResponse.h"

@interface PersonalFavoritesListRequest : AbstractRequest
/** 
 * 经度
 */
@property (nonatomic, readwrite, copy) NSNumber *api_storeLat;
/** 
 * 纬度
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
