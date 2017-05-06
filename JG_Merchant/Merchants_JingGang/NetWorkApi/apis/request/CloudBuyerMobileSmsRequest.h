//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "CloudBuyerMobileSmsResponse.h"

@interface CloudBuyerMobileSmsRequest : AbstractRequest
/** 
 * 验证类型
 */
@property (nonatomic, readwrite, copy) NSString *api_type;
/** 
 * 手机号
 */
@property (nonatomic, readwrite, copy) NSString *api_mobile;
@end
