//
//  WXPayRequestModel.h
//  jingGang
//
//  Created by 张康健 on 15/8/18.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "BaseModel.h"

@interface WXPayRequestModel : BaseModel

//公众账号ID
@property (nonatomic,  copy) NSString *appid;
//随机字符串
@property (nonatomic,  copy) NSString *noncestr;
//扩展字段
@property (nonatomic,  copy) NSString *package1;
//商户号
@property (nonatomic,  copy) NSString *partnerid;
//预支付交易会话ID
@property (nonatomic,  copy) NSString *prepayid;
//时间戳
@property (nonatomic,  copy) NSString *timestamp;
//微信支付paysignkey
@property (nonatomic,  copy) NSString *sign;

@end
