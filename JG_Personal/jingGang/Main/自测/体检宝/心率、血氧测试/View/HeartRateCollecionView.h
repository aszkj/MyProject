//
//  HeartRateCollecionView.h
//  jingGang
//
//  Created by 张康健 on 15/7/27.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMDownloadIndicator.h"
@interface HeartRateCollecionView : UIView
@property (weak, nonatomic) IBOutlet RMDownloadIndicator *heatRateProgressView;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end
