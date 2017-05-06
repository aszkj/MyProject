//
//  GoodsRefundModel.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/18.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "GoodsRefundModel.h"

@implementation GoodsRefundModel

-(NSString *)orderStatusStr {
    
    //团购信息状态，默认为0，使用后为1，过期为-1，审核中为3，审核通过为5，审核不通过为6，退款完成为7
    NSString *orderStatusstr = nil;
    switch (self.status.integerValue) {
        case 1:
            orderStatusstr = @"已消费";
            break;
        case -1:
            orderStatusstr = @"已过期";
            break;
        case 3:
            orderStatusstr = @"审核中";
            break;
        case 5:
            orderStatusstr = @"审核通过";
        case 6:
            orderStatusstr = @"审核不通过";
            break;
        case 7:
            orderStatusstr = @"已退款";
            break;
        default:
            break;
    }
    
    return orderStatusstr;
}


-(NSString *)dateStr {
    
    NSString *dateStr = [NSString stringWithFormat:@"%@",self.orderTime];
    //处理时间
    dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(4, 1) withString:@"年"];
    dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(7, 1) withString:@"月"];
    dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(10, 1) withString:@"日 "];
    dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(16, 3) withString:@""];
    
    
    return dateStr;
}




@end
