//
//  GroupOrderModel.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/12.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "GroupOrderModel.h"
#import "NSDate+Utilities.h"
#import <UIKit/UIKit.h>

@implementation GroupOrderModel

/*
 	//订单状态|0为订单取消，10为已提交待付款，20为已付款，30为买家已使用，全部使用后更新该值,50买家评价完毕 ,65订单不可评价
 */
-(NSString *)orderStatusStr {
    
    NSString *orderStatusstr = nil;
    switch (self.orderStatus.integerValue) {
        case 0:
            orderStatusstr = @"已取消";
            break;
        case 10:
            orderStatusstr = @"待付款";
            break;
        case 20:
            orderStatusstr = @"未消费";
            break;
        case 30:
        case 60:
            orderStatusstr = @"已消费";
            break;
        case 50:
            orderStatusstr = @"已完成";
            break;
        case 65:
            orderStatusstr = @"不可评价";
            break;
        default:
            break;
    }

    return orderStatusstr;
}

-(NSString *)offLineOrderStatusStr {
    NSString *offLineStatusStr = nil;
    if (self.localReturnStatus.integerValue == 1) {
        offLineStatusStr = @"未退款";
    }else if (self.localReturnStatus.integerValue == 2) {
        offLineStatusStr = @"已退款";
    }
    return offLineStatusStr;
}


-(NSString *)displayName {

    NSString *disPlayName = self.nickName;
    if (!self.nickName) {//昵称为空，显示非会员
        disPlayName = @"非会员";
    }
    
    return disPlayName;
}


-(NSString *)dateStr {

    NSString *dateStr = [NSString stringWithFormat:@"%@",self.addTime];
    //处理时间
    dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(4, 1) withString:@"年"];
    dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(7, 1) withString:@"月"];
    dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(10, 1) withString:@"日 "];
    dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(16, 3) withString:@""];
    
  
    return dateStr;
}



-(BOOL)hasReturnedMoney {
    BOOL hasReturn = NO;
    if (self.localReturnStatus.integerValue == 1) {//未退款
        hasReturn = NO;
    }else if(self.localReturnStatus.integerValue == 2){//已退款
        hasReturn = YES;
    }
    return hasReturn;
}



@end
