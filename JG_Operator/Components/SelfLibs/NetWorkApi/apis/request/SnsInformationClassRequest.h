//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "SnsInformationClassResponse.h"

@interface SnsInformationClassRequest : AbstractRequest
/** 
 * 传入资讯分类id，查询该分类下的一级子分类
 */
@property (nonatomic, readwrite, copy) NSNumber *api_parentClassId;
@end
