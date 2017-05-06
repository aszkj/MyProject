//
//  DLAdressListViewModel.m
//  YilidiBuyer
//
//  Created by yld on 16/4/26.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLAdressListViewModel.h"
#import "AdressModel.h"
#import "NSArray+extend.h"
#import "AFNHttpRequestOPManager+RACRequest.h"

@implementation DLAdressListViewModel


-(RACSignal *)requestSetDefaultAdressWithAdressId:(NSString *)adressId {
    self.requestParam = @{@"shippingAddressId":adressId};
    return [AFNHttpRequestOPManager rac_PostWithSubUrl:kUrl_SetDefaultAdress parameters:self.requestParam subScribeResultBlock:^RACDisposable *(id result, NSError *error, id<RACSubscriber> subscriber) {
        [subscriber sendNext:result];
        [subscriber sendCompleted];
        return nil;
    }];
}

-(RACSignal *)requesteleteAdressWithAdressId:(NSString *)adressId {
    self.requestParam = @{@"addressId":adressId};
    return [AFNHttpRequestOPManager rac_PostWithSubUrl:kUrl_DeleteAdress parameters:self.requestParam subScribeResultBlock:^RACDisposable *(id result, NSError *error, id<RACSubscriber> subscriber) {
        [subscriber sendNext:result];
        [subscriber sendCompleted];
        return nil;
    }];
}

-(NSArray *)getTestAdressListData {

    AdressModel *model1 = [[AdressModel alloc] init];
    model1.consigneePersonName = @"张三";
    model1.consigneePersonPhoneNumber = @"13227320992";
    model1.consigneePersonAdress = @"谁都放假啦瞬间放大了空间法拉盛江东父老看";
    
    AdressModel *model2 = [[AdressModel alloc] init];
    model2.consigneePersonName = @"李四";
    model2.consigneePersonPhoneNumber = @"13227320992";
    model2.consigneePersonAdress = @"放大了空间法拉盛江东父老看";

    return @[model1,model2];
}


-(RACSignal *)requestAdresslist {
        
    return [AFNHttpRequestOPManager rac_PostWithSubUrl:kUrl_GetAdressList parameters:nil subScribeResultBlock:^RACDisposable *(id result, NSError *error, id<RACSubscriber> subscriber) {
        if (isEmpty(result[EntityKey])) {
            [subscriber sendNext:@[]];
            [subscriber sendCompleted];
            return nil;
        }
        
        NSArray *resultArr = result[EntityKey];
            NSArray *transferedArr = [resultArr transferDicArrToModelArrWithModelClass:[AdressModel class]];
            [subscriber sendNext:transferedArr];
            [subscriber sendCompleted];
            
            return nil;
    }];
   
}

-(void)deleteAdressAtRow:(NSInteger)deleteAdressAtRow {

    [self.adressList removeObjectAtIndex:deleteAdressAtRow];
}
@end
