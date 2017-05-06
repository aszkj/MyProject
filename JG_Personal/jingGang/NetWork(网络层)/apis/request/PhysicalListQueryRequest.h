//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PhysicalListQueryResponse.h"

@interface PhysicalListQueryRequest : AbstractRequest
/** 
 * 体检时间
 */
@property (nonatomic, readwrite, copy) NSString *api_time;
@end
