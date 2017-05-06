//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ShopCartGoodsDetailResponse.h"

@interface ShopCartGoodsDetailRequest : AbstractRequest
/** 
 * 购物车商品id，用逗号隔开|1,2,3,4,5,6,7
 */
@property (nonatomic, readwrite, copy) NSString *api_gcs;
/** 
 * giftids
 */
@property (nonatomic, readwrite, copy) NSString *api_giftids;
@end
