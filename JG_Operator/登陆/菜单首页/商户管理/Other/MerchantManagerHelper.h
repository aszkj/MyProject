//
//  MerchantManagerHelper.h
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/19.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "BaseTopbarTypeHelper.h"

typedef enum : NSUInteger {
    LishuMerchantType,      //隶属商户
    XiaNeiMerchantType,     //辖内商户
}MerchantType;

@interface MerchantManagerHelper : BaseTopbarTypeHelper

@property (nonatomic, assign)MerchantType merchantType;

@end
