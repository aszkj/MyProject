//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "SnsConsultingRepayAddResponse.h"

@interface SnsConsultingRepayAddRequest : AbstractRequest
/** 
 * 咨询提问id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_consultingId;
/** 
 * 回复内容
 */
@property (nonatomic, readwrite, copy) NSString *api_content;
@end
