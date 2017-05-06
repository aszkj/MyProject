//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "IntegralGoodCountGetResponse.h"

@interface IntegralGoodCountGetRequest : AbstractRequest
/** 
 * 商品id,以‘，’号隔开
 */
@property (nonatomic, readwrite, copy) NSString *api_ids;
@end
