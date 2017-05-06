//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "OperatorMoneyCashResponse.h"

@interface OperatorMoneyCashRequest : AbstractRequest
/** 
 * 提现金额
 */
@property (nonatomic, readwrite, copy) NSNumber *api_money;
/** 
 * 密码
 */
@property (nonatomic, readwrite, copy) NSString *api_password;
@end
