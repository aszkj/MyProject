//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "SalePromotionAdInfoResponse.h"

@interface SalePromotionAdInfoRequest : AbstractRequest
/** 
 * 活动代码
 */
@property (nonatomic, readwrite, copy) NSString *api_actCode;
@end
