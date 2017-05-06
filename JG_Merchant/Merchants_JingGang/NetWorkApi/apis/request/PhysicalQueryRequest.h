//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PhysicalQueryResponse.h"

@interface PhysicalQueryRequest : AbstractRequest
/** 
 * 体检时间
 */
@property (nonatomic, readwrite, copy) NSString *api_time;
/** 
 * 体检项目类型
 */
@property (nonatomic, readwrite, copy) NSNumber *api_type;
@end
