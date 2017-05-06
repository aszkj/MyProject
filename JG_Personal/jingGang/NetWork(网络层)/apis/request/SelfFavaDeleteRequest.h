//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "SelfFavaDeleteResponse.h"

@interface SelfFavaDeleteRequest : AbstractRequest
/** 
 * 收藏id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_id;
/** 
 * 类型|1，帖子 2，医生 3,商品 4店铺,5服务,6商户
 */
@property (nonatomic, readwrite, copy) NSString *api_type;
@end
