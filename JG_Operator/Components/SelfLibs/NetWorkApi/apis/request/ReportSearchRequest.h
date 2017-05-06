//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ReportSearchResponse.h"

@interface ReportSearchRequest : AbstractRequest
/** 
 * 体检项名称
 */
@property (nonatomic, readwrite, copy) NSString *api_name;
@end
