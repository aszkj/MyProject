//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ShopGoodsConsultSaveResponse.h"

@interface ShopGoodsConsultSaveRequest : AbstractRequest
/** 
 * 商品id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_goodsId;
/** 
 * 商品咨询内容
 */
@property (nonatomic, readwrite, copy) NSString *api_content;
@end
