//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GoodsEvaluateResponse.h"

@interface GoodsEvaluateRequest : AbstractRequest
/** 
 * 评论类型|goods:商品
 */
@property (nonatomic, readwrite, copy) NSString *api_evaluateType;
/** 
 * 商品id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_goodsId;
/** 
 * 100:晒单图片  |买家评价，评价类型，1为好评，0为中评，-1为差评 ，100 晒单
 */
@property (nonatomic, readwrite, copy) NSString *api_goodsEva;
/** 
 * 每页记录数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/** 
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;
@end
