//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ReportAddResponse.h"

@interface ReportAddRequest : AbstractRequest
/** 
 * 报告id|添加不用传
 */
@property (nonatomic, readwrite, copy) NSNumber *api_replyId;
/** 
 * 报告名称
 */
@property (nonatomic, readwrite, copy) NSString *api_reportName;
/** 
 * 体检时间|yyyy-MM-dd
 */
@property (nonatomic, readwrite, copy) NSString *api_time;
/** 
 * 体检机构/医院
 */
@property (nonatomic, readwrite, copy) NSString *api_hospital;
@end
