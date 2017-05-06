//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "SnsInfomationClassResponse.h"

@interface SnsInfomationClassRequest : AbstractRequest
/** 
 * 传入分类id，查询该分类下的一级子分类
 */
@property (nonatomic, readwrite, copy) NSNumber *api_parentClassId;
@end
