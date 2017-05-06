//
//  RecordView.h
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/29.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Waver.h"

typedef int (^UpdateVolumeBlock)(void);

@interface RecordView : UIView

#define errorImageTag   123
#define transImageTag   124
#define releaseImageTag 125

@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) Waver *waver;
@property (nonatomic, strong) UIImageView *animateView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic,copy) UpdateVolumeBlock updateVolumeBlock;
@property (nonatomic) UIImageView *microphoneView;

@property (nonatomic) UILabel *contentLabel;
@property (nonatomic) UIImageView *transformImage;

- (void)updateAnimateViewWithVolume:(CGFloat)volume;
- (void)recordFaile;
- (void)showTransforming;
- (void)showRelaseView;
- (void)initView;
- (void)showMicrophoneView;

@end
