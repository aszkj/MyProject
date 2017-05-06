//
//  OperatorClient.h
//  Operator_JingGang
//
//  Created by ray on 15/9/18.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import <ReactiveCocoa.h>
#import "XKO_HttpRequestHelper.h"

@interface OperatorClient : NSObject<DataCenterDelegate>

/**
 *  与服务器连接的数据中心
 */
@property (nonatomic, strong) XKO_HttpRequestHelper *dataCenter;
@property (nonatomic, strong) MBProgressHUD *HUD;

/**
 *  运营商收益明细
 */
- (RACSignal *)operatorProfitListRequestSize:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum;
/**
 *  运营商提现明细
 */
- (RACSignal *)operatorCashmoneyDetailsRequestSize:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum;
/**
 *  运营商提现
 */
- (RACSignal *)operatorMoneyCashRequestMoney:(NSNumber *)money password:(NSString *)password;
/**
 *  获取运营商基本信息
 */
- (RACSignal *)operatorInfoRequest;
/**
 *  获取运营商会员列表
 */
- (RACSignal *)operatorMemberListRequestSize:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum;
/**
 *  问题反馈
 *
 *  @param source  来源
 *  @param content 反馈内容
 *
 */
- (RACSignal *)usersFeedBack:(NSNumber *)source content:(NSString *)content;

/**
 *  获取银行信息
 *
 *  @param type 1商户 2运营商
 */
+ (RACSignal *)getBankInfo:(NSInteger)type;

+ (RACSignal *)yunbiInfoSignal;
+ (RACSignal *)takeMoneySignalSignal:(NSNumber *)cashAmount payment:(NSString *)cashPayment
                            userName:(NSString *)cashUserName bank:(NSString *)cashBank
                             account:(NSString *)cashAccount password:(NSString *)password
                                info:(NSString *)cashInfo usrType:(NSNumber *)usrType;

@end
