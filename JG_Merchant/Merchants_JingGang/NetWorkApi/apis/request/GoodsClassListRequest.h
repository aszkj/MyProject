//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GoodsClassListResponse.h"

@interface GoodsClassListRequest : AbstractRequest
/** 
 * 商品分类编号|1一级2二级3三级
 */
@property (nonatomic, readwrite, copy) NSNumber *api_classNum;
/** 
 * 商品分类编号|第一级为空
 */
@property (nonatomic, readwrite, copy) NSNumber *api_classId;
@end
