//
//  XKO_ViewModel.m
//  Operator_JingGang
//
//  Created by ray on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_ViewModel.h"

@implementation XKO_ViewModel

- (APIManager *)client {
    if (_client == nil) {
        _client = [[APIManager alloc] init];
    }
    return _client;
}

- (NSError *)createError:(NSString *)message {
    NSError *error = [[NSError alloc] initWithDomain:@"00" code:0 userInfo:[NSDictionary dictionaryWithObject:message                                                                      forKey:NSLocalizedDescriptionKey]];
    self.error = error;
    return error;
}

@end
