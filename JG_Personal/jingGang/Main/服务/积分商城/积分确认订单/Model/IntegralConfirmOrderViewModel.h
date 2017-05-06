//
//  IntegralPayViewModel.h
//  jingGang
//
//  Created by ray on 15/10/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "XKO_ViewModel.h"

@interface IntegralConfirmOrderViewModel : XKO_ViewModel
@property (nonatomic) NSString *goodsID;
@property (nonatomic) NSArray<__kindof IntegralGoodsDetails *> *IntegralGoods;
@property (nonatomic) ShopUserAddress *defaultAddress;
@property (nonatomic) OrderBO *orderBO;
@property (nonatomic) ComputeOrderBO *computeOrderBO;
@property (nonatomic) NSAttributedString *feeString;
@property (nonatomic) NSString *feedMessage;

@property (nonatomic) RACCommand *getAddressCommand;
@property (nonatomic) RACCommand *createOrderCommand;
@property (nonatomic) RACCommand *getTransPriceCommand;

@end
