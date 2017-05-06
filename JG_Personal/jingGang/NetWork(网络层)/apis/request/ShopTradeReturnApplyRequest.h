//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ShopTradeReturnApplyResponse.h"

@interface ShopTradeReturnApplyRequest : AbstractRequest
/** 
 * 订单id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_orderId;
/** 
 * 退货原因
 */
@property (nonatomic, readwrite, copy) NSString *api_returnGoodsContent;
/** 
 * 商品id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_goodsId;
/** 
 * 商品sku ids
 */
@property (nonatomic, readwrite, copy) NSString *api_goodsGspIds;
@end
