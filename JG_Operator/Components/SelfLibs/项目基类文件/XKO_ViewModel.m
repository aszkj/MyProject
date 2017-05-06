//
//  XKO_ViewModel.m
//  Operator_JingGang
//
//  Created by ray on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_ViewModel.h"

@implementation XKO_ViewModel

- (OperatorClient *)client {
    if (_client == nil) {
        _client = [[OperatorClient alloc] init];
    }
    return _client;
}

@end
