//
//  DLEditAdressViewModel.h
//  YilidiBuyer
//
//  Created by yld on 16/4/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseViewModel.h"
#import "AdressBaseModel.h"
@interface DLEditAdressViewModel : BaseViewModel

-(void)requestAdressDetailInfoWithAdressId:(NSString *)adressId
                                 backBlcok:(BackWithObjBlock)backBlcok;

-(void)requestEditAdressWithAdressParam:(NSDictionary *)adressParam
                              backBlcok:(BackWithDicBlock)backBlcok;

-(void)requestAddAdressWithAdressParam:(NSDictionary *)adressParam
                             backBlcok:(BackWithDicBlock)backBlcok;

-(void)requestDeleteAdressWithAdressId:(NSString *)addressId
                             BackBlock:(BackWithDicBlock)backBlock;

- (NSString *)varyFyEditAdressInputPersonName:(NSString *)personName
                                 personNumber:(NSString *)personNumber
                                       adress:(NSString *)adress
                                  detailAress:(NSString *)detailAdress;



@end
