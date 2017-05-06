//
//  DLGrabRedPacketResultPageVC.h
//  YilidiBuyer
//
//  Created by yld on 16/10/19.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLBuyerBaseController.h"
#import "DLGrabRedPacketGameInfoModel.h"
#import "ProjectRelativeConst.h"

typedef void(^GoonGrabRedPacketBlock)(DLGrabRedPacketGameInfoModel *redPacketGameInfoModel,BOOL hasRedPacketGame);
@interface DLGrabRedPacketResultPageVC : DLBuyerBaseController

@property (nonatomic,copy)GoonGrabRedPacketBlock goonGrabRedPacketBlock;

@property (nonatomic,copy)PopToLastPageBlock backBlock;


@property (nonatomic,copy)NSArray *grabedCoupList;



@end
