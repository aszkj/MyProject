//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "EquipDayQueryByRangeResponse.h"

@interface EquipDayQueryByRangeRequest : AbstractRequest
/** 
 * 开始日期|如：2016-01-08格式年月日
 */
@property (nonatomic, readwrite, copy) NSString *api_startDateStr;
/** 
 * 结束日期|如：2016-01-08格式年月日
 */
@property (nonatomic, readwrite, copy) NSString *api_endDateStr;
@end
