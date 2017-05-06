//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PhysicalDescriptionResponse.h"

@interface PhysicalDescriptionRequest : AbstractRequest
/** 
 * 体检项目类型id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_phySicalTypeId;
@end
