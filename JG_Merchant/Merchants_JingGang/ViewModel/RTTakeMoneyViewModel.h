//
//  RTTakeMoneyViewModel.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKO_ViewModel.h"

typedef void(^TakeRecordViewControllerPushBlock)(void);

@interface RTTakeMoneyViewModel : XKO_ViewModel

@property (copy) TakeRecordViewControllerPushBlock pushBlock;
@property (nonatomic) RACCommand *getYunbiCommand;
@property (nonatomic) NSNumber *balance;

@property (nonatomic) RACCommand *getBankInfoCommand;
@property (nonatomic) RACCommand *takeMoneyCommand;
@property (nonatomic) NSNumber *cashAmount;
@property (nonatomic, copy) NSString *cashPayment;
@property (nonatomic) NSString *cashName;
@property (nonatomic) NSString *cashBank;
@property (nonatomic) NSString *cashAccount;
@property (nonatomic) NSString *cashPassword;
@property (nonatomic) NSString *cashInfo;

@end
