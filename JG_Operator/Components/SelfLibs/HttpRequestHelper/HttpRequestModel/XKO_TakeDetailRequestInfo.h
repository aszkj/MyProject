//
//  XKO_TakeDetailRequestInfo.h
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_BaseHttpRequestModel.h"

@interface XKO_TakeDetailRequestInfo : XKO_BaseHttpRequestModel

@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/**
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;

- (id)initWithPageSize:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum;

@end
