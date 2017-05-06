//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "SnsConsultingDetailResponse.h"

@interface SnsConsultingDetailRequest : AbstractRequest
/** 
 * 咨询提问id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_cid;
@end