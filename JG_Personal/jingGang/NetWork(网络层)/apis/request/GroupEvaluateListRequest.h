//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GroupEvaluateListResponse.h"

@interface GroupEvaluateListRequest : AbstractRequest
/** 
 * 1:图片上传/尚未评价 2:客户已评价  3:商户已评价/评价完成
 */
@property (nonatomic, readwrite, copy) NSNumber *api_status;
/** 
 * 店铺id
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
