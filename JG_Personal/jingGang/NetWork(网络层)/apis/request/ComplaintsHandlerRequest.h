//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ComplaintsHandlerResponse.h"

@interface ComplaintsHandlerRequest : AbstractRequest
/** 
 * id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_id;
/** 
 * 处理结果
 */
@property (nonatomic, readwrite, copy) NSString *api_result;
@end
