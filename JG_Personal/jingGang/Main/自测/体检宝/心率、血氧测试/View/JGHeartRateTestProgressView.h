//
//  JGHeartRateTestProgressView.h
//  jingGang
//
//  Created by dengxf on 16/2/25.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGHeartRateTestProgressView : UIView

@property (assign, nonatomic) CGFloat heartRate;

- (void)setHeartRateData:(int)rateData;
@end
