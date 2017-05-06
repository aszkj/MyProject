//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ShopCartRemoveResponse.h"

@interface ShopCartRemoveRequest : AbstractRequest
/** 
 * 商品id|多个id以逗号隔开如：1,2,3,4,5,6,7
 */
@property (nonatomic, readwrite, copy) NSString *api_goodsId;
@end
