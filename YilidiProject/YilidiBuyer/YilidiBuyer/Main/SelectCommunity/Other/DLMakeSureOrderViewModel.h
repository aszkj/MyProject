//
//  DLMakeSureOrderViewModel.h
//  YilidiBuyer
//
//  Created by yld on 16/4/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseViewModel.h"
#import "AdressBaseModel.h"
@interface DLMakeSureOrderViewModel : BaseViewModel

-(void)requestTheDefaultAdressbackBlock:(BackWithObjBlock)backBlock;

-(void)requestTheMakeSureOrderDatabackBlock:(BackWithObjBlock)backBlock;


@end
