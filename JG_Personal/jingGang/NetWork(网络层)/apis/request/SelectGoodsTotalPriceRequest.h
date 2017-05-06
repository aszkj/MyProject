//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "SelectGoodsTotalPriceResponse.h"

@interface SelectGoodsTotalPriceRequest : AbstractRequest
/** 
 * 选中商品id，已逗号隔开|如1,2,3,4,5,6,7
 */
@property (nonatomic, readwrite, copy) NSString *api_gcids;
@end
