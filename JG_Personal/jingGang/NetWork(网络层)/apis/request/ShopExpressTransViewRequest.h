//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ShopExpressTransViewResponse.h"

@interface ShopExpressTransViewRequest : AbstractRequest
/** 
 * 快递号
 */
@property (nonatomic, readwrite, copy) NSString *api_expressCode;
/** 
 * 快递公司 id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_expressCompanyId;
@end
