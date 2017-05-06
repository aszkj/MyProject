//
//  XKO_MembersManagerResponseInfo.m
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_MembersManagerResponseInfo.h"
#import "NSDate+Utilities.h"

@implementation XKO_MembersManagerResponseInfo

- (void)setStoreName:(NSString *)storeName {
    _storeName = [NSString stringWithFormat:@"商户名称：%@",storeName];
}

- (void)setCreateTime:(NSString *)createTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:createTime];
//    _createTime = [NSString stringWithFormat:@"注册时间：%ld年%ld月%ld日 %d:%d",date.year,(long)date.month,(long)date.day,(int)date.hour,(int)date.seconds];
    _createTime = [NSString stringWithFormat:@"注册时间：%04ld-%02ld-%02ld %02d:%02d:%02d",date.year,(long)date.month,(long)date.day,(int)date.hour,(int)date.minute,(int)date.seconds];
}

@end
