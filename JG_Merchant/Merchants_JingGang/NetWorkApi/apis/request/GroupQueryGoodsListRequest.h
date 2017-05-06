//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GroupQueryGoodsListResponse.h"

@interface GroupQueryGoodsListRequest : AbstractRequest
/** 
 * 商品状态|  0为上架，1为在仓库中，2为定时自动上架，3为店铺过期自动下架，-1为手动下架状态，-2为违规下架状态,-3被举报禁售',
 */
@property (nonatomic, readwrite, copy) NSNumber *api_ggStatus;
/** 
 * 商品类型|1为套餐券 2为代金券
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
