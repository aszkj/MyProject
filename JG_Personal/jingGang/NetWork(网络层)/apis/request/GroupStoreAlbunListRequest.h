//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GroupStoreAlbunListResponse.h"

@interface GroupStoreAlbunListRequest : AbstractRequest
/** 
 * 店铺id|商户端不需要传，个人端需要
 */
@property (nonatomic, readwrite, copy) NSNumber *api_storeId;
/** 
 * 每页记录数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/** 
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;
@end
