//
//  FeelBackViewModel.m
//  Operator_JingGang
//
//  Created by ray on 15/11/6.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "FeelBackViewModel.h"

@interface FeelBackViewModel ()

@property (nonatomic) NSNumber *source;

@end

@implementation FeelBackViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.source = @4;
        @weakify(self)
        [[self.commitCommand executing] subscribeNext:^(NSNumber *executing) {
            @strongify(self)
            if (executing.boolValue != self.isExcuting) {
                self.isExcuting = executing.boolValue;
            }
        }];
    }
    return self;
}

- (RACCommand *)commitCommand {
    if (_commitCommand == nil) {
        @weakify(self)
        _commitCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [[[MerchantClient usersFeedBack:self.source content:self.content] doNext:^(UsersFeedBackResponse *response) {
                
            }] doError:^(NSError *error) {
                self.error = error;
            }];
        }];
    }
    return _commitCommand;
}

@end
