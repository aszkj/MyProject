//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "LikeYouGoodsListResponse.h"

@interface LikeYouGoodsListRequest : AbstractRequest
/** 
 * 商品id,以逗号隔开|如1,2,3,4,5,6,7
 */
@property (nonatomic, readwrite, copy) NSString *api_likeIds;
/** 
 * 每页记录数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/** 
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;
@end
