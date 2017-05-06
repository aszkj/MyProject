//
//  DLMakeSureOrderViewModel.m
//  YilidiBuyer
//
//  Created by yld on 16/4/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLMakeSureOrderViewModel.h"

@implementation DLMakeSureOrderViewModel

-(void)requestTheDefaultAdressbackBlock:(BackWithObjBlock)backBlock {
    
    [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_GetDefaultAdress parameters:nil block:^(id result, NSError *error) {
        NSDictionary *resultDic = result[@"data"];
        AdressBaseModel *model = nil;
        if (!isEmpty(resultDic[@"id"])) {
            model = [[AdressBaseModel alloc] initWithDefaultDataDic:resultDic];
        }
        emptyBlock(backBlock,model,error);
    }];
}


@end
