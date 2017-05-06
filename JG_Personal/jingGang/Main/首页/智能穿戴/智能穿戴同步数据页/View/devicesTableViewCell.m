//
//  devicesTableViewCell.m
//  jingGang
//
//  Created by yi jiehuang on 15/6/2.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "devicesTableViewCell.h"
#import "GlobeObject.h"

@implementation devicesTableViewCell

- (void)awakeFromNib {
    
    [self _initProgressor];
}


#pragma mark - 初始化 进度圈
-(void)_initProgressor{

    [self.rmProgresser setBackgroundColor:[UIColor clearColor]];
    //    [closedIndicator setFillColor:[UIColor colorWithRed:16./255 green:119./255 blue:234./255 alpha:1.0f]];
    UIColor *fillColor = kGetColor(222, 222, 222);
    UIColor *backGroupFillColor = kGetColor(77, 208, 200);
    [self.rmProgresser setFillColor:fillColor];
    [self.rmProgresser setClosedIndicatorBackgroundStrokeColor:fillColor];
    //    [closedIndicator setStrokeColor:[UIColor colorWithRed:16./255 green:119./255 blue:234./255 alpha:1.0f]];
    [self.rmProgresser setStrokeColor:backGroupFillColor];
    //    self.progressView.radiusPercent = 0.45;
    [self.rmProgresser loadIndicator];

}



@end
