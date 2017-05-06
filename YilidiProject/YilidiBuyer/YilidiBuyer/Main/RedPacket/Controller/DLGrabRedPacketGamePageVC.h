//
//  DLGrabRedPacketGamePageVC.h
//  YilidiBuyer
//
//  Created by mm on 16/10/24.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLBuyerBaseController.h"
#import "DLGrabRedPacketGameInfoModel.h"

@interface DLGrabRedPacketGamePageVC : DLBuyerBaseController<CAAnimationDelegate>

@property (nonatomic,strong)DLGrabRedPacketGameInfoModel *grabRedPacketGameInfoModel;

@property (nonatomic,assign)BOOL hasRedPacketGame;

@end
