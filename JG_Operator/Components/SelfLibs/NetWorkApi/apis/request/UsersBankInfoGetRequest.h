//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersBankInfoGetResponse.h"

@interface UsersBankInfoGetRequest : AbstractRequest
/** 
 * 类型|1商户2营运商
 */
@property (nonatomic, readwrite, copy) NSNumber *api_type;
@end
