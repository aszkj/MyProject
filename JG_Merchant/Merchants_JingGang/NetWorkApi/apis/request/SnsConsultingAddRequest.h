//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "SnsConsultingAddResponse.h"

@interface SnsConsultingAddRequest : AbstractRequest
/** 
 * 咨询提问id；修改问题时使用
 */
@property (nonatomic, readwrite, copy) NSNumber *api_id;
/** 
 * 专家用户id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_expertsUserId;
/** 
 * 提问标题
 */
@property (nonatomic, readwrite, copy) NSString *api_title;
/** 
 * 提问图片,多图片用｜连接
 */
@property (nonatomic, readwrite, copy) NSString *api_images;
/** 
 * 提问内容
 */
@property (nonatomic, readwrite, copy) NSString *api_content;
@end
