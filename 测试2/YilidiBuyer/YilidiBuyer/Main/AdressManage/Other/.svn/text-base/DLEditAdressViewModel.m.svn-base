//
//  DLEditAdressViewModel.m
//  YilidiBuyer
//
//  Created by yld on 16/4/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLEditAdressViewModel.h"
#import "AdressModel.h"

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
        return @"收货人姓名不能为空";
    }
    
    if (isEmpty(personNumber)) {
        return @"收货人联系方式不能为空";
    }else {
        if (![Util isValidatePhoneNumberOrTelNumber:personNumber]) {
            return @"对不起，请输入正确的电话号码";
        }
    }
    
    if (isEmpty(detailAdress)) {
        return @"门牌号不能为空";
    }
    
    return nil;
}




@end
