//
//  XKO_ViewModel.m
//  Operator_JingGang
//
//  Created by ray on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_ViewModel.h"

@implementation XKO_ViewModel

- (RACCommand *)createCommandForSelector:(SEL)signalSelector {
    @weakify(self)
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        IMP imp = [self methodForSelector:signalSelector];
        RACSignal*(*func)(id, SEL) = (void *)imp;
        return func(self, signalSelector);
    }];
    return command;
}

@end
