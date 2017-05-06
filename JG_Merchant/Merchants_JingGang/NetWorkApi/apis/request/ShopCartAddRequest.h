//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ShopCartAddResponse.h"

@interface ShopCartAddRequest : AbstractRequest
/** 
 * 商品id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_goodId;
/** 
 * 商品数量
 */
@property (nonatomic, readwrite, copy) NSNumber *api_count;
/** 
 * 商品的属性值，这里传递id值，如12,1,21
 */
@property (nonatomic, readwrite, copy) NSString *api_gsp;
@end
