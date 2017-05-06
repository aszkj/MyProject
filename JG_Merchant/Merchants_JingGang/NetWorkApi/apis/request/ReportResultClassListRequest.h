//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ReportResultClassListResponse.h"

@interface ReportResultClassListRequest : AbstractRequest
/** 
 * id|查询分类列表时不用传值，查询体检项列表时传分类id,常用传-1
 */
@property (nonatomic, readwrite, copy) NSNumber *api_id;
@end
