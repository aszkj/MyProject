//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GoodsConsultListResponse.h"

@interface GoodsConsultListRequest : AbstractRequest
/** 
 * 咨询类型|0全部咨询1产品咨询|2库存及配送3支付及发票4售后咨询5促销活动
 */
@property (nonatomic, readwrite, copy) NSNumber *api_consulType;
/** 
 * 商品id|必填
 */
@property (nonatomic, readwrite, copy) NSNumber *api_goodsId;
@end
