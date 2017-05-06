//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersFeedBackResponse.h"

@interface UsersFeedBackRequest : AbstractRequest
/** 
 * 来源n1：IOS个人端APP 2：IOS商户端APP 3：IOS运营商APP 4：安卓个人端APP 5：安卓商户端APP 6：安卓运营商APP
 */
@property (nonatomic, readwrite, copy) NSNumber *api_source;
/** 
 * 反馈内容
 */
@property (nonatomic, readwrite, copy) NSString *api_content;
@end
