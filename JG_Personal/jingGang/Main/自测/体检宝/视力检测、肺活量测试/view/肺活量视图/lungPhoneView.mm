//
//  lungPhoneView.m
//  jingGang
//
//  Created by thinker on 15/7/27.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "lungPhoneView.h"
#import "PublicInfo.h"
#import "POVoiceHUD.h"
#import "Physical.h"
#import "VitalCapacityListener.h"
#import "WSJLungResultViewController.h"
#define K_Heigth (__MainScreen_Height - 108 - 40)

@interface lungPhoneView ()<POVoiceHUDDelegate>
{
    UILabel *_label;
    
    Physical *_physical;
    VitalCapacityListener *_vcl;
    
}

@property (nonatomic, strong) POVoiceHUD *voice;//监听音频数据
@property (nonatomic, assign) NSInteger resultLungValue;//肺活量最终结果值

@end

@implementation lungPhoneView
{
    UIImageView *_centerImageView;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
//        [self startAction];
    }
    return self;
}

- (void) initUI
{
    self.voice = [[POVoiceHUD alloc] initWithParentView:self.VC.view];
    [self.voice setDelegate:self];
    
    self.backgroundColor = [UIColor colorWithRed:232.0 /255 green:232.0 /255 blue:232.0 /255 alpha:1];
    
    UIView *promptView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 40)];
    promptView.backgroundColor = [UIColor colorWithRed:217.0 / 255 green:217.0 / 255 blue:217.0 / 255 alpha:1];
    [self addSubview:promptView];
    
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, promptView.frame.size.width, promptView.frame.size.height)];
    promptLabel.text = @"请在比较安静的环境下测试";
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.font = [UIFont systemFontOfSize:16];
    [promptView addSubview:promptLabel];
    
    UIImageView *promptImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconfont-tishi_看图王"]];
    promptImageView.bounds = CGRectMake(0, 0, 25, 25);
    promptImageView.center = CGPointMake(__MainScreen_Width / 2 - 120,20);
    [promptView addSubview:promptImageView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40 + K_Heigth / 3 * 2, __MainScreen_Width, K_Heigth / 9 )];
    _label.text = @"请点击下方按钮";
    _label.textColor = [UIColor colorWithRed:102.0 / 255 green:102.0 / 255 blue:102.0 / 255 alpha:1];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:16];
    [self addSubview:_label];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconfont-youxiang_看图王"]];
    img.center = CGPointMake(__MainScreen_Width / 2, K_Heigth / 9 + CGRectGetMaxY(_label.frame));
    img.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAction)];
    [img addGestureRecognizer:tap];
    img.bounds = CGRectMake(0, 0, K_Heigth / 9 * 2 - 10, K_Heigth / 9 * 2 - 10);
    [self addSubview:img];
    
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
    v.center = CGPointMake(__MainScreen_Width / 2, 43 + K_Heigth / 3);
    v.bounds = CGRectMake(0, 0, K_Heigth / 3 * 2 - 30, K_Heigth / 3 * 2 - 30);
    [self addSubview:v];
    
    
    _centerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"little-fengche"]];
    _centerImageView.contentMode = UIViewContentModeScaleAspectFit;
    _centerImageView.center = CGPointMake(v.frame.size.width / 2, v.frame.size.height / 3);
    _centerImageView.bounds = CGRectMake(0, 0, v.frame.size.height / 3 * 2, v.frame.size.height / 3 * 2);
   
    
    UIImageView *assistor = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"棍子---Assistor"]];
    assistor.frame = CGRectMake(_centerImageView.center.x - 3 , _centerImageView.center.y, 6, v.frame.size.height - _centerImageView.center.y);
    [v addSubview:assistor];
    [v addSubview:_centerImageView];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(backStop) name:@"backViewControllerStopVoice" object:nil];
 
#if TARGET_IPHONE_SIMULATOR
    
#else
    //C++语言初始化，主要是
    _physical = new Physical();
    
    _vcl = new VitalCapacityListener();
#endif

    
}
//退出界面时，停止对麦克风的监听
- (void) backStop
{
    _label.text = @"请点击下方按钮";
    [self.voice stop];
}

#pragma mark - 中心图片进行旋转
- (void) imageViewTransformWithTime:(NSTimeInterval)time
{
    CGAffineTransform transform = _centerImageView.transform;
    CGAffineTransform newATF = CGAffineTransformRotate(transform, 15 * M_PI / 180) ;
    [UIView animateWithDuration:time animations:^{
        _centerImageView.transform = newATF;
    }];
}
- (void) startAction
{
    _label.text = @"对准手机下端麦克风吹吧";
    [_voice startMonitor];
#if TARGET_IPHONE_SIMULATOR
    
#else
    _physical->startVitalCapacity(_vcl);

#endif
}
#pragma mark - POVoiceHUDDelegate
- (void)POVoiceHUD:(POVoiceHUD *)voiceHUD voiceRecorded:(NSString *)recordPath length:(float)recordLength//吹起结束，或者超时回调
{
    _label.text = @"请点击下方按钮";
    NSLog(@"你吹了%lf秒%@=====%d  resultValue = %ld",recordLength,[recordPath lastPathComponent],(int)(recordLength*700),(long)self.resultLungValue);
    WSJLungResultViewController *lungResultVC = [[WSJLungResultViewController alloc] initWithNibName:@"WSJLungResultViewController" bundle:nil];
    lungResultVC.lungValue = self.resultLungValue;
    [self.VC.navigationController pushViewController:lungResultVC animated:YES];
}
- (void) start//吹起时回调
{
    NSLog(@"您开始吹了");
    [self imageViewTransformWithTime:1];
}
- (void) POVoiceHUD:(CGFloat)value
{
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
//    NSLog(@"time --- %lld",recordTime);
    if (value<0) {
        value = (-value) *11;
    }
#if TARGET_IPHONE_SIMULATOR
    
#else
    _physical->update(value, recordTime);
    self.resultLungValue = _vcl->finalLungCapacity;

#endif

}

@end
