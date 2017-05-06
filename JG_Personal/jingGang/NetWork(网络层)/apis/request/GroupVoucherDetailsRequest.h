//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GroupVoucherDetailsResponse.h"

@interface GroupVoucherDetailsRequest : AbstractRequest
/** 
 * 消费码
 */
@property (nonatomic, readwrite, copy) NSString *api_groupSn;
@end
