//
//  XKJHStatisticsHeader.h
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalenderView.h"

typedef void (^BtnPressBlk)(NSString *startTime, NSString *endTime);

@interface XKJHStatisticsHeader : UIView

@property (nonatomic,strong) UIButton *startTimeBtn;
@property (nonatomic,strong) UIButton *endTimeBtn;
@property (nonatomic,strong) UILabel *totalBillText;
@property (nonatomic, copy) BtnPressBlk btnPressBlock;

@end
