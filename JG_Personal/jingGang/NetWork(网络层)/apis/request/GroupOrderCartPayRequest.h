//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GroupOrderCartPayResponse.h"

@interface GroupOrderCartPayRequest : AbstractRequest
/** 
 * 手机号码
 */
@property (nonatomic, readwrite, copy) NSString *api_mobile;
/** 
 * 价格
 */
@property (nonatomic, readwrite, copy) NSNumber *api_price;
/** 
 * 服务项目
 */
@property (nonatomic, readwrite, copy) NSString *api_goodsName;
@end
