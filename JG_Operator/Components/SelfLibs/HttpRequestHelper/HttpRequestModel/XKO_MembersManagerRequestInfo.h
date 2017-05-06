//
//  XKO_MembersManagerRequestInfo.h
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_BaseHttpRequestModel.h"

@interface XKO_MembersManagerRequestInfo : XKO_BaseHttpRequestModel

@property (nonatomic, copy) NSNumber *api_pageSize;
/**
 * 页数|必须
 */
@property (nonatomic, copy) NSNumber *api_pageNum;

- (id)initWithPageSize:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum methordName:(NSString *)methordName;

@end
