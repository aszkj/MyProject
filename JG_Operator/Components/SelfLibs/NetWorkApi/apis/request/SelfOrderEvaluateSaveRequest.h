//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "SelfOrderEvaluateSaveResponse.h"

@interface SelfOrderEvaluateSaveRequest : AbstractRequest
/** 
 * 商品评论信息
 */
@property (nonatomic, readwrite, copy) NSString *api_evaluateInfo;
@end
