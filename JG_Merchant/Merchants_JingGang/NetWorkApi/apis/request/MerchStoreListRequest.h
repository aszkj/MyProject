//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "MerchStoreListResponse.h"

@interface MerchStoreListRequest : AbstractRequest
/** 
 * 分类id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_ugcId;
/** 
 * 店铺id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_id;
/** 
 * orderBy|销量:goods_salenum;好评:well_evaluate;价格:goods_current_price
 */
@property (nonatomic, readwrite, copy) NSString *api_orderBy;
/** 
 * orderType|升序:desc;降序:asc
 */
@property (nonatomic, readwrite, copy) NSString *api_orderType;
/** 
 * 每页记录数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/** 
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;
@end
