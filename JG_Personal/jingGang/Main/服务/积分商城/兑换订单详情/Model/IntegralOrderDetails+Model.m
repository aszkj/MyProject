//
//  IntegralOrderDetails+Model.m
//  jingGang
//
//  Created by ray on 15/11/2.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "IntegralOrderDetails+Model.h"

@implementation IntegralOrderDetails (Model)
@dynamic orderSNString,totalIntegralString,transPayString,addTimeString,payWayString
,payTimeString,payMessageString,recieverString,areaString,postCodeString,addressString
,telString,phoneNumberString,transCompanyString,sendTimeString,transNumberString,transMessageString;

- (NSString *)orderSNString {
    return [NSString stringWithFormat:@"订单编号：%@",[self checkNil:self.igoOrderSn]];
}

- (NSString *)totalIntegralString {
    return [NSString stringWithFormat:@"兑换积分：%@",[self checkNil:self.igoTotalIntegral.stringValue]];
}

- (NSString *)transPayString {
    return [NSString stringWithFormat:@"运费：%@",[self checkNil:[self.igoTransFee stringValue]]];
}

- (NSString *)addTimeString {
    return [NSString stringWithFormat:@"兑换时间：%@",[self checkNil:(NSString *)self.addTime]];
}

- (NSString *)payWayString {
    return [NSString stringWithFormat:@"支付方式：%@",[self checkNil:self.payment]];
}

- (NSString *)payTimeString {
    return [NSString stringWithFormat:@"支付时间：%@",[self checkNil:(NSString *)self.igoPayTime]];
}

- (NSString *)payMessageString {
    return [NSString stringWithFormat:@"支付留言：%@",[self checkNil:self.igoMsg]];
}

- (NSString *)recieverString {
    return [NSString stringWithFormat:@"收货人：%@",[self checkNil:self.receiverName]];
}

- (NSString *)areaString {
    return [NSString stringWithFormat:@"收货地区：%@",[self checkNil:self.receiverArea]];
}

- (NSString *)postCodeString {
    return [NSString stringWithFormat:@"邮编：%@",[self checkNil:self.receiverZip]];
}

- (NSString *)addressString {
    return [NSString stringWithFormat:@"详细地址：%@",[self checkNil:self.receiverAreaInfo]];
}

- (NSString *)telString {
    return [NSString stringWithFormat:@"电话号码：%@",[self checkNil:self.receiverTelephone ]];
}

- (NSString *)phoneNumberString {
    return [NSString stringWithFormat:@"手机号码：%@",[self checkNil:self.receiverMobile]];
}

- (NSString *)sendTimeString {
    return [NSString stringWithFormat:@"发货时间：%@",[self checkNil:(NSString *)self.igoShipTime]];
}

- (NSString *)transNumberString {
    return [NSString stringWithFormat:@"物流单号：%@",[self checkNil:self.igoShipCode]];
}

- (NSString *)transMessageString {
    return [NSString stringWithFormat:@"发货说明：%@",[self checkNil:self.igoShipContent]];
}

- (NSString *)transCompanyString {
    return [NSString stringWithFormat:@"物流公司：%@",[self checkNil:self.expressInfo]];
}

- (NSString *)checkNil:(NSString *)input {
    NSString *result = @"";
    if (input != nil) {
        result = input;
    }
    return result;
}

@end
