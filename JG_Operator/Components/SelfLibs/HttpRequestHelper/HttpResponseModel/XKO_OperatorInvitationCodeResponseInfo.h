//
//  XKO_OperatorInvitationCodeResponseInfo.h
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/30.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_BaseHttpResponseModel.h"

@interface XKO_OperatorInvitationCodeResponseInfo : XKO_BaseHttpResponseModel

//营运商邀请码
@property (nonatomic, readwrite, copy) NSString *invitationCode;

@end
