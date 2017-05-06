//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PersonalCommentSaveResponse.h"

@interface PersonalCommentSaveRequest : AbstractRequest
/** 
 * 订单id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_orderId;
/** 
 * 评论内容
 */
@property (nonatomic, readwrite, copy) NSString *api_content;
/** 
 * 评论星级|如1，2，3，4，5，6.....
 */
@property (nonatomic, readwrite, copy) NSNumber *api_evaluationAverage;
/** 
 * 图片|以;号分割，最多6张
 */
@property (nonatomic, readwrite, copy) NSString *api_photo;
@end
