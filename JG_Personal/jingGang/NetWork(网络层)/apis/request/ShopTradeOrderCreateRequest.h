//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ShopTradeOrderCreateResponse.h"

@interface ShopTradeOrderCreateRequest : AbstractRequest
/** 
 * 送货地址
 */
@property (nonatomic, readwrite, copy) NSNumber *api_addrId;
/** 
 * 运输方式，类型：平邮、快递、EMS，格式 "{"店铺id":"平邮","店铺id":"快递"}" 自营使用self 例：{"self":"快递"}
 */
@property (nonatomic, readwrite, copy) NSString *api_transportIds;
/** 
 * 订单留言，格式 "{"店铺id":"留言"}" 自营使用self 例：{"self":"加价"}
 */
@property (nonatomic, readwrite, copy) NSString *api_msgs;
/** 
 * 优惠劵id，格式 "{"店铺id":优惠劵id}" 自营使用self 例：{"self":1}
 */
@property (nonatomic, readwrite, copy) NSString *api_couponIds;
/** 
 * 使用积分兑购商品，格式为购物车id ","分隔  例：12,13
 */
@property (nonatomic, readwrite, copy) NSString *api_integralIds;
/** 
 * 所提交的购物车商品, 格式为购物车id ","分隔  例：12,13
 */
@property (nonatomic, readwrite, copy) NSString *api_gcIds;
@end
