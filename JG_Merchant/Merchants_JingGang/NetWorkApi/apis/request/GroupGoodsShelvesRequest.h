//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GroupGoodsShelvesResponse.h"

@interface GroupGoodsShelvesRequest : AbstractRequest
/** 
 * 商品id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_goodsId;
/** 
 * 状态|0为上架，1为在仓库中，2为定时自动上架，3为店铺过期自动下架，-1为手动下架状态，-2为违规下架状态,-3被举报禁售
 */
@property (nonatomic, readwrite, copy) NSNumber *api_goodsStatus;
@end
