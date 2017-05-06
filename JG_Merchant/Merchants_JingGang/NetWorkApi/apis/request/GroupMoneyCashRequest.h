//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GroupMoneyCashResponse.h"

@interface GroupMoneyCashRequest : AbstractRequest
/** 
 * 提现金额
 */
@property (nonatomic, readwrite, copy) NSNumber *api_cashAmount;
/** 
 * 提款方式|alipay_app|chinabank
 */
@property (nonatomic, readwrite, copy) NSString *api_cashPayment;
/** 
 * 提款人姓名
 */
@property (nonatomic, readwrite, copy) NSString *api_cashUserName;
/** 
 * 银行
 */
@property (nonatomic, readwrite, copy) NSString *api_cashBank;
/** 
 * 收款账号 
 */
@property (nonatomic, readwrite, copy) NSString *api_cashAccount;
/** 
 * 取款密码
 */
@property (nonatomic, readwrite, copy) NSString *api_cashPassword;
/** 
 * 提现备注
 */
@property (nonatomic, readwrite, copy) NSString *api_cashInfo;
/** 
 * 提现用户|1商户2营运商
 */
@property (nonatomic, readwrite, copy) NSNumber *api_userType;
@end
