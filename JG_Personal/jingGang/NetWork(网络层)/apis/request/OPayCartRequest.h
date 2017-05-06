//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "OPayCartResponse.h"

@interface OPayCartRequest : AbstractRequest
/** 
 * 手机好
 */
@property (nonatomic, readwrite, copy) NSString *api_mobile;
/** 
 * 消费金额
 */
@property (nonatomic, readwrite, copy) NSNumber *api_price;
/** 
 * 消费项目
 */
@property (nonatomic, readwrite, copy) NSString *api_item;
@end
