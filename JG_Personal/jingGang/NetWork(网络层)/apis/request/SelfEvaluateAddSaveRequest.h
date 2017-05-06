//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "SelfEvaluateAddSaveResponse.h"

@interface SelfEvaluateAddSaveRequest : AbstractRequest
/** 
 * 评论id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_evalId;
/** 
 * 追加评论内容
 */
@property (nonatomic, readwrite, copy) NSString *api_evaluateInfo;
/** 
 * 图片地址
 */
@property (nonatomic, readwrite, copy) NSString *api_imgPath;
@end
