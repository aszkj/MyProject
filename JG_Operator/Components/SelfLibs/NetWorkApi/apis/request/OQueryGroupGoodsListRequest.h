//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "OQueryGroupGoodsListResponse.h"

@interface OQueryGroupGoodsListRequest : AbstractRequest
/** 
 * 店铺id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_storeId;
/** 
 * 商品状态
 */
@property (nonatomic, readwrite, copy) NSNumber *api_ggStatus;
/** 
 * 商品类型
 */
@property (nonatomic, readwrite, copy) NSNumber *api_goodsType;
/** 
 * 每页记录数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/** 
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;
@end
