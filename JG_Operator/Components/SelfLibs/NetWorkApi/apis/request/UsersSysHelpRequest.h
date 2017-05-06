//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersSysHelpResponse.h"

@interface UsersSysHelpRequest : AbstractRequest
/** 
 * code|papphelp个人，mapphelp商户，oapphelp营运商,pappabout个人关于,mappabout商户关于，oappabout营运商关于
 */
@property (nonatomic, readwrite, copy) NSString *api_code;
@end
