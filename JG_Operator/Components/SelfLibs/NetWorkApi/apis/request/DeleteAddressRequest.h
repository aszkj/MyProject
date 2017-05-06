//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "DeleteAddressResponse.h"

@interface DeleteAddressRequest : AbstractRequest
/** 
 * 地址ids|多个有逗号隔开如1，2，3，4，5，6，7
 */
@property (nonatomic, readwrite, copy) NSString *api_ids;
@end
