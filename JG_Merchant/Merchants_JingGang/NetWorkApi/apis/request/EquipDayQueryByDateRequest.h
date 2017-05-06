//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "EquipDayQueryByDateResponse.h"

@interface EquipDayQueryByDateRequest : AbstractRequest
/** 
 * 日期|如：2016-01-08字符串格式年月日
 */
@property (nonatomic, readwrite, copy) NSString *api_dayDateStr;
@end
