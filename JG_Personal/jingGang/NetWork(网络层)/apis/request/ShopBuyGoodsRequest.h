//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ShopBuyGoodsResponse.h"

@interface ShopBuyGoodsRequest : AbstractRequest
/** 
 * 商品id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_goodsId;
/** 
 * 数量
 */
@property (nonatomic, readwrite, copy) NSNumber *api_count;
/** 
 * 属性
 */
@property (nonatomic, readwrite, copy) NSString *api_gsp;
@end
