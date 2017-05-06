//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "SnsIntegralGetResponse.h"

@interface SnsIntegralGetRequest : AbstractRequest
/** 
 * 类型|1注册
 */
@property (nonatomic, readwrite, copy) NSNumber *api_type;
@end
