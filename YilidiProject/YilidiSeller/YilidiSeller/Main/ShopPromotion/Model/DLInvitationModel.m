//
//  DLInvitationModel.m
//  YilidiSeller
//
//  Created by 曾勇兵 on 16/6/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLInvitationModel.h"

@implementation DLInvitationModel
- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    if (self) {
        self.userMaskMobile = dic[@"userMaskMobile"];
        self.username = dic[@"userName"];
        self.vipFlag = dic[@"vipFlag"];
    }
    
    
    return  self;
    
}

@end


@implementation DLInvitationModel (invitationModel)

+ (NSArray *)objectWithInvitationModelArray:(NSArray *)array {

    NSMutableArray *mutableArr = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        DLInvitationModel *model = [[DLInvitationModel alloc]initWithDefaultDataDic:dic];
        
        [mutableArr addObject:model];
    }
    
    return [mutableArr mutableCopy];
}

@end