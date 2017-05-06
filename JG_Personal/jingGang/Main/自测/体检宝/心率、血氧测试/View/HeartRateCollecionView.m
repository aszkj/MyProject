//
//  HeartRateCollecionView.m
//  jingGang
//
//  Created by 张康健 on 15/7/27.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "HeartRateCollecionView.h"
#import "GlobeObject.h"

@implementation HeartRateCollecionView

-(void)awakeFromNib{

    [self _initProgressor];

}

#pragma mark - 初始化 进度圈
-(void)_initProgressor{
    
    [self.heatRateProgressView setBackgroundColor:[UIColor clearColor]];
    //    [closedIndicator setFillColor:[UIColor colorWithRed:16./255 green:119./255 blue:234./255 alpha:1.0f]];
//    UIColor *fillColor = [UIColor whiteColor];
    UIColor *fillColor = [UIColor groupTableViewBackgroundColor];
    UIColor *backGroupFillColor = kGetColor(94, 180, 231);
//    UIColor *backGroupFillColor = [UIColor blueColor];
    
    [self.heatRateProgressView setFillColor:fillColor];
    [self.heatRateProgressView setClosedIndicatorBackgroundStrokeColor:fillColor];
    //    [closedIndicator setStrokeColor:[UIColor colorWithRed:16./255 green:119./255 blue:234./255 alpha:1.0f]];
    [self.heatRateProgressView setStrokeColor:backGroupFillColor];
    //    self.progressView.radiusPercent = 0.45;
    self.heatRateProgressView.coverWidth = 5.0f;
    [self.heatRateProgressView loadIndicator];
    [self.heatRateProgressView updateWithTotalBytes:100 downloadedBytes:0];
    
}


@end
