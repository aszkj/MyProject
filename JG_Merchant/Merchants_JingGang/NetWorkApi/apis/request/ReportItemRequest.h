//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ReportItemResponse.h"

@interface ReportItemRequest : AbstractRequest
/** 
 * 体检项id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_id;
@end
