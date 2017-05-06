//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"


@interface EquipAddStepsListRequest : AbstractRequest
/** 
 * json格式字符串：手环记录数据
 */
@property (nonatomic, readwrite, copy) NSString *api_jsonStr;
@end
