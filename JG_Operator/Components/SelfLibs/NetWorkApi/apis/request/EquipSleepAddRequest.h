//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "EquipSleepAddResponse.h"

@interface EquipSleepAddRequest : AbstractRequest
/** 
 * 睡眠时长
 */
@property (nonatomic, readwrite, copy) NSNumber *api_sleepSecond;
/** 
 * 深睡时长
 */
@property (nonatomic, readwrite, copy) NSNumber *api_deepSleepSecond;
/** 
 * 浅睡时长
 */
@property (nonatomic, readwrite, copy) NSNumber *api_shallowSleepSecond;
@end
