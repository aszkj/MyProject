//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "EquipAddResponse.h"

@interface EquipAddRequest : AbstractRequest
/** 
 * 总步数
 */
@property (nonatomic, readwrite, copy) NSNumber *api_stepNumber;
/** 
 * 身高
 */
@property (nonatomic, readwrite, copy) NSNumber *api_heigth;
/** 
 * 体重
 */
@property (nonatomic, readwrite, copy) NSNumber *api_weight;
/** 
 * 记录时间
 */
@property (nonatomic, readwrite, copy) NSDate *api_recordDate;
@end
