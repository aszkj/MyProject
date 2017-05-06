//
//  MerchantManagerViewModel.h
//  Operator_JingGang
//
//  Created by ray on 15/9/18.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "XKO_TableViewModel.h"

typedef enum : NSUInteger {
    MerchantTypeBlong = 1,  //辖内商户
    MerchantTypeOwen = 0,   //隶属商户
} MerchantType;

typedef enum : NSUInteger {
    MerchantCountTypeTotal = 0, //总统计
    MerchantCountTypeWeek = 1,  //周统计
    MerchantCountTypeMonth = 2, //月统计
    MerchantCountTypeSeason = 3,//季统计
    MerchantCountTypeYear = 4,  //年统计
} MerchantCountType;

@interface MerchantManagerViewModel : XKO_TableViewModel

@property (nonatomic) MerchantType merchantType;

@end
