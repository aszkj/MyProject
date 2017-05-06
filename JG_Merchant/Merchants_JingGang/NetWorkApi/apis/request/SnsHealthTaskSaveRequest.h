//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "SnsHealthTaskSaveResponse.h"

@interface SnsHealthTaskSaveRequest : AbstractRequest
/** 
 * 积分类型|1健康任务2分享
 */
@property (nonatomic, readwrite, copy) NSNumber *api_integralType;
@end
