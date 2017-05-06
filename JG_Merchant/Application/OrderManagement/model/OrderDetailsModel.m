//
//  OrderDetailsModel.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/16.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "OrderDetailsModel.h"

@implementation OrderDetailsModel

-(NSString *)dateStr {
    
    NSString *dateStr = [NSString stringWithFormat:@"%@",self.addTime];
    //处理时间
    NSInteger length = dateStr.length;
    if (length > 3) {
        _dateStr = [dateStr substringToIndex:length-3];
    }
    return _dateStr;
}



@end
