//
//  DLPaySuccessVC.h
//  YilidiSeller
//
//  Created by yld on 16/7/2.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLBuyerBaseController.h"
#import "ProjectRelativeConst.h"

@interface DLPaySuccessVC : DLBuyerBaseController

@property (nonatomic,copy)NSString *orderNo;

@property (nonatomic,strong)NSNumber *orderAmount;

@property (nonatomic,strong)NSNumber *couponAmount;

@property (nonatomic,copy)BackPayRreshBlock backPayRreshBlock;

@property (nonatomic,assign)BOOL isComeFromSettleAcount;

@end
