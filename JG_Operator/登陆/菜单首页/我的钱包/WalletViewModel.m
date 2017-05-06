//
//  WalletViewModel.m
//  Operator_JingGang
//
//  Created by ray on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "WalletViewModel.h"

@interface WalletViewModel ()

@property (nonatomic) RACCommand *getYunbiCommand;

@end

@implementation WalletViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"我的钱包";
       @weakify(self)
        [[self.getYunbiCommand executing] subscribeNext:^(NSNumber *executing) {
            @strongify(self)
            if (executing.boolValue != self.isExcuting) {
                self.isExcuting = executing.boolValue;
            }
        }];
    }
    return self;
}

- (RACCommand *)getYunbiCommand {
    if (_getYunbiCommand == nil) {
        _getYunbiCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[[OperatorClient yunbiInfoSignal] doNext:^(GroupAvailableBalanceGetResponse *response) {
                [self setYunbi:response.balance.stringValue];
            }] doError:^(NSError *error) {
                self.error = error;
            }];
        }];
    }
    return _getYunbiCommand;
}

- (void)getYunbiResques {
    [self.getYunbiCommand execute:nil];
}

- (void)setYunbi:(NSString *)number {
    if (number == nil) {  number = @"0";  }
    NSMutableDictionary *attributeDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont systemFontOfSize:30.0],NSFontAttributeName,
                                   [UIColor whiteColor],NSForegroundColorAttributeName,
                                   nil];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:number attributes:attributeDict];
    [attributeDict setValue:[UIFont systemFontOfSize:24.0] forKey:NSFontAttributeName];
    [attributeString appendAttributedString:[[NSAttributedString alloc] initWithString:@" " attributes:attributeDict]];
    self.yunbiString = attributeString;
}
- (NSArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = @[@"提现明细",@"收益明细",@"预期收益"];
    }
    return _dataSource;
}
@end
