//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersFavoritesResponse.h"

@interface UsersFavoritesRequest : AbstractRequest
/** 
 * 收藏内容的id
 */
@property (nonatomic, readwrite, copy) NSString *api_fid;
/** 
 * 类型1帖子2医生3商品 4店铺5服务6商户
 */
@property (nonatomic, readwrite, copy) NSString *api_type;
@end
