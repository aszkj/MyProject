//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GoodsListResponse.h"

@interface GoodsListRequest : AbstractRequest
/** 
 * 商品分类id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_classId;
/** 
 * 搜索关键字
 */
@property (nonatomic, readwrite, copy) NSString *api_keyword;
/** 
 * 是否有商品库存
 */
@property (nonatomic, readwrite, copy) NSNumber *api_isGoodsInventory;
/** 
 * 每页记录数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/** 
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;
@end
