//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GroupConsumerSureMultiResponse.h"

@interface GroupConsumerSureMultiRequest : AbstractRequest
/** 
 * 多个消费码
 */
@property (nonatomic, readwrite, copy) NSString *api_multiGroupSn;
@end
