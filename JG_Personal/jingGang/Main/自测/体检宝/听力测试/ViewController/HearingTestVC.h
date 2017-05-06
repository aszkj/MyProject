//
//  HearingTestVC.h
//  jingGang
//
//  Created by 张康健 on 15/7/23.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYDwaveform.h"
#import "hearingResultView.h"


@interface HearingTestVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *speedButton; //快进
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;//前进
@property (weak, nonatomic) IBOutlet UIButton *rewindButton;//快退
@property (weak, nonatomic) IBOutlet UIButton *backButton;//后退

@property (weak, nonatomic) IBOutlet UILabel *frequencyLabel;//最终频率
@property (weak, nonatomic) IBOutlet UISlider *frequencySlider;//频率进度条
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;//音量进度条
@property (weak, nonatomic) IBOutlet hearingResultView *resultSlider;//结果进度条

@property (weak, nonatomic) IBOutlet LYDwaveform *waveView; //波形图

@property (weak, nonatomic) IBOutlet UIButton *percentageBtn; //百分比按钮
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *percentage;

- (IBAction)speedAction:(UIButton *)sender;//快进事件
- (IBAction)forwardAction:(UIButton *)sender;//前进事件
- (IBAction)backAction:(UIButton *)sender;//后退事件
- (IBAction)rewindAction:(UIButton *)sender;//快退事件
- (IBAction)hearAction:(UIButton *)sender;//听见事件
- (IBAction)commitAction:(UIButton *)sender;//提交事件
- (IBAction)volumeAction:(UISlider *)sender;//设置音量事件

@end
