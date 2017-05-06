//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "SnsBodyListResponse.h"

@interface SnsBodyListRequest : AbstractRequest
/** 
 * 类型|0形体1症状
 */
@property (nonatomic, readwrite, copy) NSNumber *api_type;
@end
