//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ShopAddresListResponse.h"

@interface ShopAddresListRequest : AbstractRequest
/** 
 * 父级id|第一级为0
 */
@property (nonatomic, readwrite, copy) NSNumber *api_id;
@end
