//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ShopTradeReturnShipSaveResponse.h"

@interface ShopTradeReturnShipSaveRequest : AbstractRequest
/** 
 * 退货记录id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_returnGoodsLogId;
/** 
 * 物流公司id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_expressId;
/** 
 * 订单号
 */
@property (nonatomic, readwrite, copy) NSString *api_expressCode;
@end
