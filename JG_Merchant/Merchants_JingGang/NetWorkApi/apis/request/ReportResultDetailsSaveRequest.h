//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ReportResultDetailsSaveResponse.h"

@interface ReportResultDetailsSaveRequest : AbstractRequest
/** 
 * 体检报告id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_replyId;
/** 
 * 体检项id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_itemId;
/** 
 * 具体值
 */
@property (nonatomic, readwrite, copy) NSNumber *api_value;
/** 
 * 报告明细id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_detailsId;
@end
