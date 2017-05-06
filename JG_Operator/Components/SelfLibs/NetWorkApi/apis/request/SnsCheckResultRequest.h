//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "SnsCheckResultResponse.h"

@interface SnsCheckResultRequest : AbstractRequest
/** 
 * 自测套题id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_groupId;
/** 
 * 自测套题结果得分
 */
@property (nonatomic, readwrite, copy) NSNumber *api_resultScore;
@end
