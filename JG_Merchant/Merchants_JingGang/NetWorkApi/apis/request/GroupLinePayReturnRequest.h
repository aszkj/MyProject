//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GroupLinePayReturnResponse.h"

@interface GroupLinePayReturnRequest : AbstractRequest
/** 
 * 订单号
 */
@property (nonatomic, readwrite, copy) NSString *api_out_trade_no;
@end
