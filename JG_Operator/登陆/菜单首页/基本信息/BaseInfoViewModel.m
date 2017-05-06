//
//  BaseInfoViewModel.m
//  Operator_JingGang
//
//  Created by ray on 15/9/18.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "BaseInfoViewModel.h"

@implementation BaseInfoViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"基本信息";
    }
    return self;
}

- (RACCommand *)baseInfoCommand {
    if (_baseInfoCommand == nil) {
        
    }
    return _baseInfoCommand;
}

@end
