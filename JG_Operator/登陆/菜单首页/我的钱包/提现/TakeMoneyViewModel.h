//
//  TakeMoneyViewModel.h
//  Operator_JingGang
//
//  Created by ray on 15/9/18.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "XKO_ViewModel.h"

typedef void(^TakeRecordViewControllerPushBlock)(void);

@interface TakeMoneyViewModel : XKO_ViewModel

@property (copy) TakeRecordViewControllerPushBlock pushBlock;
@property (nonatomic) RACCommand *getYunbiCommand;
@property (nonatomic) NSNumber *balance;

@property (nonatomic) RACCommand *getBankInfoCommand;
@property (nonatomic) RACCommand *takeMoneyCommand;
@property (nonatomic) NSNumber *cashAmount;
@property (nonatomic) NSString *cashPayment;
@property (nonatomic) NSString *cashName;
@property (nonatomic) NSString *cashBank;
@property (nonatomic) NSString *cashAccount;
@property (nonatomic) NSString *cashPassword;
@property (nonatomic) NSString *cashInfo;

@end
