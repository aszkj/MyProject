//
//  IntegralDetailViewModel.h
//  jingGang
//
//  Created by ray on 15/10/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "XKO_ViewModel.h"
#import "IntegralOrderDetails+Model.h"

@interface IntegralDetailViewModel : XKO_ViewModel

@property (nonatomic) NSNumber *orederId;
@property (nonatomic) IntegralOrderDetails *detail;
@property (nonatomic) UserIntegral *userIntegral;

@property (nonatomic) RACCommand *getDetailCommand;
@property (nonatomic) RACCommand *getUserIntegralCommand;
@end
