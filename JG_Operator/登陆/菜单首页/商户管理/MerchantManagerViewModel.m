//
//  MerchantManagerViewModel.m
//  Operator_JingGang
//
//  Created by ray on 15/9/18.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "MerchantManagerViewModel.h"

@implementation MerchantManagerViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.merchantType = MerchantTypeOwen;
    }
    return self;
}
@end
