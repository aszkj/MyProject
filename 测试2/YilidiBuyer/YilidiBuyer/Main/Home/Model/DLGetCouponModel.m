//
//  DLGetCouponModel.m
//  YilidiBuyer
//
//  Created by yld on 16/5/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGetCouponModel.h"

@implementation DLGetCouponModel
- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic
{
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.couponId = [dic[@"couponId"] intValue];
        self.couponName = dic[@"couponName"] ;
        self.couponValue = [NSNumber numberWithDouble:[dic[@"couponValue"]doubleValue]];
        self.expirationDate = [self setDate:dic[@"expirationDate"]];
        self.descr = dic[@"descr"];
        self.isReceive = [dic[@"isReceive"] boolValue];
        
        }
    return self;
}

- (NSString *)setDate:(NSString *)str {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[str integerValue]/1000];
    
    [formatter setDateFormat:@"YYYY.MM.dd"];
    NSString *stringDate = [formatter stringFromDate:confromTimesp];
    return stringDate;
    
}
@end
