//
//  DLInvitationOrdetailsModel.m
//  YilidiSeller
//
//  Created by yld on 16/6/7.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLInvitationOrdetailsModel.h"

@implementation DLInvitationOrdetailsModel
- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    if (self) {
        self.selected = NO;
        self.saleProductName = dic[@"saleProductName"];
        self.allotCount = [dic[@"allotCount"] integerValue];
        self.realAllotCount = [dic[@"realAllotCount"]integerValue];
        self.saleProductImageUrl = dic[@"saleProductImageUrl"];
        self.saleProductId = [dic[@"saleProductId"] integerValue];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedMode:) name:@"InvitationNotification" object:nil];
        
    }
    
    return self;
}

- (void)selectedMode:(NSNotification *)no {
    
    NSLog(@"%@",no.object);
    self.selected = [no.object integerValue];
    
}
//
- (void)dealloc {

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end

@implementation DLInvitationOrdetailsModel (setInvitationOrdertaiModel)


+ (NSArray *)objectWithInvitationModelArr:(NSArray *)array isInspectionHidden:(BOOL)hidden isReceiveHidden:(BOOL)receiveHidden {
    
    NSMutableArray *orderArr = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        DLInvitationOrdetailsModel *model = [[DLInvitationOrdetailsModel alloc]initWithDefaultDataDic:dic];
        model.selected=hidden;
        model.isReceiveHidden = receiveHidden;
        [orderArr addObject:model];
    }
    
    return [orderArr mutableCopy];
}

@end
