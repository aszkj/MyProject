//
//  WSJBloodPressureViewController.m
//  jingGang
//
//  Created by thinker on 15/7/30.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJBloodPressureViewController.h"
#import "PublicInfo.h"
#import "JGShareView.h"
#import "PhysicalSaveRequest.h"
#import "GlobeObject.h"
#import "VApiManager.h"
#import "RMDownloadIndicator.h"

typedef void(^PopBlock)(void);

@interface WSJBloodPressureViewController ()
{
    CGFloat _lung;
    CADisplayLink * _link;
}
////领取按钮
//@property (weak, nonatomic) IBOutlet UIButton *receiveBtn;
@property (weak, nonatomic) IBOutlet RMDownloadIndicator *progressPressureView;//圆圈
@property (weak, nonatomic) IBOutlet UILabel *resultValueLabel;  //最终血压值
@property (weak, nonatomic) IBOutlet UILabel *statusLabel; //状态，血压
//中间Label
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;//温馨提示
@property (weak, nonatomic) IBOutlet UILabel *saveDataLabel;//保存数据提示
//健康币
@property (copy , nonatomic) PopBlock popBlock;

@end

@implementation WSJBloodPressureViewController


-(instancetype)initWithPop:(void (^)())popBlock {
    if (self = [super init]) {
        self.popBlock = popBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadViewLeftBarButton];
    [self initUI];
    [self setResultData];
    [self saveData];
    [self initProgressView];
}
//初始化圆圈UI
- (void) initProgressView
{
    [self.progressPressureView setBackgroundColor:[UIColor clearColor]];
    //    [closedIndicator setFillColor:[UIColor colorWithRed:16./255 green:119./255 blue:234./255 alpha:1.0f]];
    //    UIColor *fillColor = [UIColor whiteColor];
    UIColor *fillColor = UIColorFromRGB(0Xbbbbbb);
    UIColor *backGroupFillColor = kGetColor(94, 180, 231);
    //    UIColor *backGroupFillColor = [UIColor blueColor];
    
    [self.progressPressureView setFillColor:fillColor];
    [self.progressPressureView setClosedIndicatorBackgroundStrokeColor:fillColor];
    //    [closedIndicator setStrokeColor:[UIColor colorWithRed:16./255 green:119./255 blue:234./255 alpha:1.0f]];
    [self.progressPressureView setStrokeColor:backGroupFillColor];
    //    self.progressView.radiusPercent = 0.45;
    self.progressPressureView.coverWidth = 10.0f;
    [self.progressPressureView loadIndicator];
    [self.progressPressureView updateWithTotalBytes:(self.highPressure + self.lowPressure) downloadedBytes:self.highPressure];
}
- (void) saveData
{
    self.saveDataLabel.layer.cornerRadius = 5;
    VApiManager * _manager = [[VApiManager alloc ]init];
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia"];
    NSDate *date = [NSDate date];
    
    PhysicalSaveRequest *saveRequest = [[PhysicalSaveRequest alloc] init:GetToken];
    saveRequest.api_type = @(6);
    saveRequest.api_maxValue = @(self.highPressure);
    saveRequest.api_minValue = @(self.lowPressure);
    saveRequest.api_time = [formatter stringFromDate:date];
    WEAK_SELF
    [_manager physicalSave:saveRequest success:^(AFHTTPRequestOperation *operation, PhysicalSaveResponse *response) {
        NSLog(@"succeed = %@",response);
        if (response.errorCode == nil)
        {
            [weak_self saveDataSuccessTishi:YES];
        }
        else
        {
            [weak_self saveDataSuccessTishi:NO];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure = %@",error);
        [weak_self saveDataSuccessTishi:NO];
    }];
}
- (void) saveDataSuccessTishi:(BOOL)b
{
    self.saveDataLabel.layer.cornerRadius = 5;
    if (!b)
    {
        self.saveDataLabel.text = @"数据保存失败";
    }WEAK_SELF
    [UIView animateWithDuration:1 animations:^{
        weak_self.saveDataLabel.alpha = 1;
    } completion:^(BOOL finished) {
        [NSThread sleepForTimeInterval:2];
        [UIView animateWithDuration:3 animations:^{
            weak_self.saveDataLabel.alpha = 0;
        }];
    }];
}

- (void) setResultData
{
//    self.progressView.z = (CGFloat)self.highPressure / (self.highPressure + self.lowPressure);
//    self.progressView.highPressure = self.highPressure;
//    self.progressView.lowPressure = self.lowPressure;
    self.resultValueLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.highPressure,self.lowPressure];

    self.statusLabel.adjustsFontSizeToFitWidth = YES;
    self.centerLabel.adjustsFontSizeToFitWidth = YES;
    if (self.highPressure < 90 || self.lowPressure < 60)
    {
        self.statusLabel.text = @"低血压";
        self.centerLabel.text = @"处于低血压，建议多食些富含高蛋白、糖类、脂类等高热量的食物，血压回升，宜适当食用能刺激食欲的食物和调味品。";
    }
    else if (self.highPressure < 120 && self.lowPressure < 80)
    {
        self.statusLabel.text = @"理想血压";
        self.centerLabel.text = @"血压测量属于理想的血压值，继续加油！";
    }
    else if (self.highPressure < 130 && self.lowPressure < 85)
    {
        self.statusLabel.text = @"正常血压";
        self.centerLabel.text = @"血压值测量正常，有空定期试试!";
    }
    else if (self.highPressure <= 140 && self.lowPressure <= 90)
    {
        self.statusLabel.text = @"血压高值";
        self.centerLabel.text = @"血压测量偏高，请密切关注血压，祝您好心情！";
    }
    
    if (self.highPressure > 140 || self.lowPressure > 90)
    {
        self.statusLabel.text = @"高血压";
        self.centerLabel.text = @"测量结果为高血压，建议您密切关注血压的变化，可以用药控制血压、饮食限制钠盐的摄入，切记禁怒，戒烟限酒！";
        if (self.highPressure < 160 && self.lowPressure < 95)
        {
            self.statusLabel.text = @"临界高血压";
            self.centerLabel.text = @"测试为临界高血压，建议饮食上适量控制能量及食盐量，降低脂肪和胆固醇的摄入水平，控制体重与利尿排钠，调节血容量。";
        }
    }
    
}
- (void) initUI
{
    self.saveDataLabel.layer.cornerRadius = 5;
    //分享按钮
    UIButton *button_Shared = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 35, __NavScreen_Height)];
    [button_Shared setImage:[UIImage imageNamed:@"life_share"] forState:UIControlStateNormal];
    [button_Shared addTarget:self action:@selector(btnShared) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar_Shared = [[UIBarButtonItem alloc]initWithCustomView:button_Shared];
    self.navigationItem.rightBarButtonItem = bar_Shared;
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    
}
#pragma mark - 设置返回按钮
- (void) loadViewLeftBarButton
{
    // 返回上一级控制器按钮
    UIButton *button_na = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 35, __NavScreen_Height-15)];
    [button_na setImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [button_na addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:button_na];
    self.navigationItem.leftBarButtonItem = bar;
}


#pragma mark - 返回上一级界面
- (void) btnClick
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers xf_safeObjectAtIndex:2] animated:YES];
//    BLOCK_EXEC(self.popBlock);
//    [self.navigationController popViewControllerAnimated:YES];
}
//分享事件
- (void) btnShared
{
    NSString *content = [NSString stringWithFormat:@"我在云e生APP上做了【血压测试】，大家一起来测试吧!下面放下载链接%@",k_ShareURL];
    JGShareView *shareView = [JGShareView shareViewWithTitle:@"血压测试" content:content imgUrlStr:k_ShareImage ulrStr:k_ShareURL contentView:self.view shareImagePath:nil];
    [shareView show];
}

#pragma mark - 标题
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
    l.text = @"血压测量结果";
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;
}

@end
