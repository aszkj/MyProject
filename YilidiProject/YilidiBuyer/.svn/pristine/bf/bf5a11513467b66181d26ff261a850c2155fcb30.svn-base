//
//  DLEditAdressViewModel.m
//  YilidiBuyer
//
//  Created by yld on 16/4/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLEditAdressViewModel.h"
#import "AdressModel.h"
#import "NSString+SUIRegex.h"

@implementation DLEditAdressViewModel

-(void)requestAdressDetailInfoWithAdressId:(NSString *)adressId
                                 backBlcok:(BackWithObjBlock)backBlcok;
{
    self.requestParam = @{@"addressId":adressId};
    [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_GetAdressDetail parameters:self.requestParam block:^(id result, NSError *error) {
        NSDictionary *dic = result[EntityKey];
        AdressModel *model = [[AdressModel alloc] initWithDefaultDataDic:dic];
        model.consigneePersonalDetailAdress = dic[@"addressDetail"];
        emptyBlock(backBlcok,model,error);
    }];
}

-(void)requestEditAdressWithAdressParam:(NSDictionary *)adressParam
                              backBlcok:(BackWithDicBlock)backBlcok{
    [AFNHttpRequestOPManager postWithParameters:adressParam subUrl:kUrl_EditAddAdress block:^(NSDictionary *resultDic, NSError *error) {
        emptyBlock(backBlcok,resultDic,error);
    }];
}

-(void)requestAddAdressWithAdressParam:(NSDictionary *)adressParam
                             backBlcok:(BackWithDicBlock)backBlcok{
    [AFNHttpRequestOPManager postWithParameters:adressParam subUrl:kUrl_EditAddAdress block:^(NSDictionary *resultDic, NSError *error) {
        emptyBlock(backBlcok,resultDic,error);
    }];
}

-(void)requestDeleteAdressWithAdressId:(NSString *)addressId
                             BackBlock:(BackWithDicBlock)backBlock {
    self.requestParam = @{@"addressId":addressId};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_DeleteAdress block:^(NSDictionary *resultDic, NSError *error) {
        emptyBlock(backBlock,resultDic,error);
    }];
}

- (NSString *)varyFyEditAdressInputPersonName:(NSString *)personName
                                 personNumber:(NSString *)personNumber
                                       adress:(NSString *)adress
                                  detailAress:(NSString *)detailAdress
{

    if (isEmpty(personName)) {
        return @"请输入收货人姓名";
    }else{
        if (![personName sui_validateName]) {
            return @"收货人姓名输入不合法";
        }
    }
    
    if (isEmpty(personNumber)) {
        return @"收货人联系方式不能为空";
    }else {
        if (![Util isValidatePhoneNumberOrTelNumber:personNumber]) {
            return @"请输入有效的11位手机号码";
        }
    }
    
    if (isEmpty(detailAdress)) {
        return @"亲，您还没有输入收货地址的详细信息";
    }else {
        if (![detailAdress sui_validateCommonInputTwo]) {
            return @"收货地址的详细信息输入不合法";
        }
    }
    
    return nil;
}




@end
