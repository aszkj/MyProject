//
//  BloodPressureCollectionView.m
//  jingGang
//
//  Created by 张康健 on 15/7/28.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "BloodPressureCollectionView.h"
#import "GlobeObject.h"
@implementation BloodPressureCollectionView

-(void)awakeFromNib{
    
    [self _initProgressor];
    
}

#pragma mark - 初始化 进度圈
-(void)_initProgressor{
    
    [self.rmBloodTestProgressView setBackgroundColor:[UIColor clearColor]];
    //    [closedIndicator setFillColor:[UIColor colorWithRed:16./255 green:119./255 blue:234./255 alpha:1.0f]];
    UIColor *fillColor = [UIColor whiteColor];
    UIColor *backGroupFillColor = kGetColor(94, 180, 231);
    [self.rmBloodTestProgressView setFillColor:fillColor];
    [self.rmBloodTestProgressView setClosedIndicatorBackgroundStrokeColor:fillColor];
    //    [closedIndicator setStrokeColor:[UIColor colorWithRed:16./255 green:119./255 blue:234./255 alpha:1.0f]];
    [self.rmBloodTestProgressView setStrokeColor:backGroupFillColor];
    //    self.progressView.radiusPercent = 0.45;
    self.rmBloodTestProgressView.coverWidth = 5.0f;
    [self.rmBloodTestProgressView loadIndicator];
    [self.rmBloodTestProgressView updateWithTotalBytes:100 downloadedBytes:0];
    
}

@end
