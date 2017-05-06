//
//  IntegralPayViewModel.m
//  jingGang
//
//  Created by ray on 15/10/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "IntegralConfirmOrderViewModel.h"
#import <UIKit/NSAttributedString.h>

@interface IntegralConfirmOrderViewModel ()
@property (nonatomic) NSString *goodsJson;
@property (nonatomic) UserIntegral *userIntegral;

@property (nonatomic) RACCommand *getUserIntegralCommand;

@end

@implementation IntegralConfirmOrderViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        @weakify(self)
        self.title = @"再次确认订单";
        RACSignal *excutingSignal =
         [RACSignal combineLatest:@[
                                   self.createOrderCommand.executing,
                                   self.getAddressCommand.executing,
                                   self.getTransPriceCommand.executing,
                                   self.getUserIntegralCommand.executing
                                   ]
                           reduce:^(
                                    NSNumber *createOrderExcuting ,
                                    NSNumber *getAddressCommandExcuting,
                                    NSNumber *getTransPriceExcuting,
                                    NSNumber *getUserIntegralExcuting
                                    ) {
                               return @(
                               getAddressCommandExcuting.boolValue
                               ||createOrderExcuting.boolValue
                               ||getTransPriceExcuting.boolValue
                               ||getUserIntegralExcuting.boolValue
                               );
           }];
        [excutingSignal subscribeNext:^(NSNumber *x) {
            @strongify(self)
            self.isExcuting = [x boolValue];
        }];
    }
    return self;
}

- (void)setComputeOrderBO:(ComputeOrderBO *)computeOrderBO {
    _computeOrderBO = computeOrderBO;
    
    NSString *string = [NSString stringWithFormat:@"所需积分%@积分  邮费 %@元",computeOrderBO.totalIntegral,computeOrderBO.totalTransportFee];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange integralRange = [string rangeOfString:[NSString stringWithFormat:@"%@积分",computeOrderBO.totalIntegral]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:status_color range:NSMakeRange(integralRange.location,integralRange.length-2)];
    NSRange transRange = [string rangeOfString:[NSString stringWithFormat:@"%@元",computeOrderBO.totalTransportFee]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:status_color range:NSMakeRange(transRange.location,transRange.length-1)];
    self.feeString = attributedString.copy;
}

- (void)setIntegralGoods:(NSArray *)IntegralGoods {
    _IntegralGoods = IntegralGoods;
    NSMutableArray *muArray = [NSMutableArray array];
    [IntegralGoods enumerateObjectsUsingBlock:^(IntegralGoodsDetails *obj, NSUInteger idx, BOOL *stop) {
        [muArray addObject:@{@"goodsId":obj.apiId,
                             @"count":obj.igExchangeCount}];
    }];
    _goodsJson = [[self.client class] DataTOjsonString:muArray];
}

- (RACCommand *)createOrderCommand {
    if (_createOrderCommand == nil) {
        @weakify(self)
        _createOrderCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [[[self.client RACCreateIntegralOrder:self.goodsJson addressId:self.defaultAddress.apiId igoMsg:self.feedMessage] doNext:^(NSArray *responseData) {
                self.orderBO = ((OrderBO *)responseData.firstObject);
            }] doError:^(NSError *error) {
                self.error = error;
            }];
        }];
    }
    return _createOrderCommand;
}

- (RACCommand *)getAddressCommand {
    if (_getAddressCommand == nil) {
        @weakify(self)
        _getAddressCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [[[self.client RACGetDefaultAddress] doNext:^(NSArray *x) {
                self.defaultAddress = x.firstObject;
            }] doError:^(NSError *error) {
                self.error = error;
            }];
        }];
    }
    return _getAddressCommand;
}

- (RACCommand *)getTransPriceCommand {
    if (_getTransPriceCommand == nil) {
        @weakify(self)
        _getTransPriceCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [[[self.client RACIntegralComputeOrder:self.goodsJson addressId:self.defaultAddress.apiId] doNext:^(NSArray *x) {
                
                self.computeOrderBO = x.firstObject;
            }] doError:^(NSError *error) {
                self.error = error;
            }];
        }];
    }
    return _getTransPriceCommand;
}

- (RACCommand *)getUserIntegralCommand {
    if (_getUserIntegralCommand == nil) {
        @weakify(self);
        _getUserIntegralCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [[[self.client RACGetUsersIntegral] doNext:^(NSArray *x) {
                self.userIntegral = x.firstObject;
            }] doError:^(NSError *error) {
                self.error = error;
            }];
        }];
    }
    return _getUserIntegralCommand;
}
@end
