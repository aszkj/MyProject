//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ShopGoodsCountAdjustResponse.h"

@interface ShopGoodsCountAdjustRequest : AbstractRequest
/** 
 * 购物车id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_gcId;
/** 
 * 商品数量
 */
@property (nonatomic, readwrite, copy) NSNumber *api_count;
@end
