//
//  XKO_TakeDetailResponseInfo.h
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_BaseHttpResponseModel.h"

@interface XKO_TakeDetailResponseInfo : XKO_BaseHttpResponseModel

//id
@property (nonatomic, readwrite, copy) NSNumber *apiId;
//提现金额
@property (nonatomic, readwrite, copy) NSNumber *cashAmount;
//提现时间
@property (nonatomic, readwrite, copy) NSString *addTime;
//提现状态 0为审核中，1为已经完成
@property (nonatomic, readwrite, copy) NSNumber *cashStatus;
//提现状态
@property (nonatomic,copy) NSString *cashStatusString;
@end
