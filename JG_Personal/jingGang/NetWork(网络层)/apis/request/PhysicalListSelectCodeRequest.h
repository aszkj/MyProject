//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PhysicalListSelectCodeResponse.h"

@interface PhysicalListSelectCodeRequest : AbstractRequest
/** 
 * 体检项目
 */
@property (nonatomic, readwrite, copy) NSString *api_itemCode;
@end
