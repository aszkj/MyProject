//
//  XKO_EarningDetailResponseInfo.h
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_BaseHttpResponseModel.h"

@interface XKO_EarningDetailResponseInfo : XKO_BaseHttpResponseModel

//店铺名称
@property (nonatomic, readonly, copy) NSString *storeName;
//返润金额
@property (nonatomic, readonly, copy) NSNumber *rebateAmount;
//返利类型
@property (nonatomic, readonly, copy) NSString *rebateType;
//创建时间
@property (nonatomic, readonly, copy) NSString *createTime;
//收益类型名称
@property (nonatomic, readonly, copy) NSString *rebateTypeName;

@end
