//
//  blindnessResultViewController.m
//  jingGang
//
//  Created by thinker on 15/7/28.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "blindnessResultViewController.h"
#import "PublicInfo.h"
#import "shareView.h"
#import "PhysicalSaveRequest.h"
#import "GlobeObject.h"
#import "VApiManager.h"
#import "JGShareView.h"

@interface blindnessResultViewController ()

//@property (weak, nonatomic) IBOutlet UILabel *jianyiLabel;
////领取按钮
//@property (weak, nonatomic) IBOutlet UIButton *receiveBtn;
//最上面的Label
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
//中间Label
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
////健康币
//@property (weak, nonatomic) IBOutlet UILabel *healthyLabel;

@property (weak, nonatomic) IBOutlet UILabel *saveDataLabel;

@end

@implementation blindnessResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self saveData];
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
    switch (self.type)
    {
        case k_Astigma://散光
        {
            saveRequest.api_type = @(4);
            saveRequest.api_maxValue = @(self.isAstigmatism ? 2: 1);
            saveRequest.api_middleValue = @(self.isAstigmatism ? 2 : 1);
        }
            break;
        case k_Blindness://色盲
        {
            saveRequest.api_type = @(3);
            saveRequest.api_maxValue = @(self.blindnessValue > 3 ? 1 : 2);
        }
            break;
        case k_Hearing://听力
        {
            saveRequest.api_type = @(5);
            saveRequest.api_maxValue = @(self.maxValue);
            saveRequest.api_minValue = @(self.minValue);
        }
            break;
        default:
            break;
    }
    WEAK_SELF
    saveRequest.api_time = [formatter stringFromDate:date];
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
    }
    WEAK_SELF
    [UIView animateWithDuration:1 animations:^{
        weak_self.saveDataLabel.alpha = 1;
    } completion:^(BOOL finished) {
        [NSThread sleepForTimeInterval:2];
        [UIView animateWithDuration:3 animations:^{
            weak_self.saveDataLabel.alpha = 0;
        }];
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
    switch (self.type) {
        case k_Astigma:
            l.text = @"散光测试结果";
            break;
        case k_Blindness:
            l.text = @"色盲测试结果";
            break;
        case k_Hearing:
            l.text = @"听力测试结果";
            break;
        default:
            break;
    }
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
//散光结果界面
- (void) initAstigmatism
{
    if (self.isAstigmatism)
    {
        self.resultLabel.text = @"散光";
        self.centerLabel.text = @"让视网膜、晶状体、视觉神经得到充足的营养。";
    }
    else
    {
        self.resultLabel.text = @"正常";
        self.centerLabel.text = @"继续保持良好习惯，坚持做眼保健操。";
    }
//    self.healthyLabel.text = @"1";
}
//色盲界面
- (void) initBlindness
{
    self.resultLabel.text = [NSString stringWithFormat:@"%ld疑似分",self.blindnessValue * 20];
    self.resultLabel.adjustsFontSizeToFitWidth = YES;
    switch (self.blindnessValue) {
        case 0:
            self.centerLabel.text = @"要多次测试确定数值，可以通过健康方式弥补自己不足。";
            break;
        case 1:
            self.centerLabel.text = @"要不定期检查和测试，纠正自己色值的感官，提升测试值。";
            break;
        case 2:
            self.centerLabel.text = @"在疲劳过度，或者工作环境造成，要改善光线和生活环境。";
            break;
        case 3:
            self.centerLabel.text = @"不注意休息，长期损害辨别力，要调整休息时间。";
            break;
        case 4:
            self.centerLabel.text = @"在一定时间内，学会释放眼睛的光线，调和眼光色值的对比度。";
            break;
        case 5:
            self.centerLabel.text = @"继续保持眼球血液循环，以及视网膜的清晰度。";
            break;
        default:
            break;
    }
//    self.healthyLabel.text = @"2";
}
//听力结果界面
- (void) initHearing
{
    self.resultLabel.text = [NSString stringWithFormat:@"%ld~%ldHz",self.minValue,self.maxValue];
    self.resultLabel.adjustsFontSizeToFitWidth = YES;
    self.centerLabel.adjustsFontSizeToFitWidth = YES;
    if (self.maxValue < 8000)
    {
        self.centerLabel.text = @"您有耳聋症状，平衡运动，膳食营养调节、药疗物疗调理、定期检查听力。";
    }
    else if (self.maxValue < 12000)
    {
        self.centerLabel.text = @"您的听力年龄在50岁以上之间，适宜运动，膳食调理、营养平衡、养生调理身心。";
    }
    else if (self.maxValue < 14000)
    {
        self.centerLabel.text = @"您的听力年龄在40岁~50岁之间，主动运动，充足睡眠、养生调理身心。";
    }
    else if (self.maxValue < 16000)
    {
        self.centerLabel.text = @"您的听力年龄在30岁~40岁之间，多运动、易安静，养生调理身心。";
    }
    else if (self.maxValue < 17000)
    {
        self.centerLabel.text = @"您的听力年龄在25岁~30岁之间，运动多听、膳食调理、释放心力。";
    }
    else if (self.maxValue < 19000)
    {
        self.centerLabel.text = @"您的听力年龄在20岁~25岁之间，适量运动，少玩听力刺激。";
    }
    else
    {
        self.centerLabel.text = @"你的听力年龄在20岁以下，保持运动、积极运用大脑。";
    }
//    self.healthyLabel.text = @"3";
}
//初始化界面数据
- (void) initUI
{
    switch (self.type)
    {
        case k_Astigma:
        {
            [self initAstigmatism];
        }
            break;
        case k_Blindness:
        {
            [self initBlindness];
        }
            break;
        case k_Hearing:
        {
            [self initHearing];
        }
            break;
            
        default:
            break;
    }
    self.saveDataLabel.layer.cornerRadius = 5;
    //返回上一级控制器按钮
    UIButton *button_na = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 35, __NavScreen_Height-15)];
    [button_na setImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [button_na addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:button_na];
    self.navigationItem.leftBarButtonItem = bar;
    //分享按钮
    UIButton *button_Shared = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 35, __NavScreen_Height)];
    [button_Shared setImage:[UIImage imageNamed:@"life_share"] forState:UIControlStateNormal];
    [button_Shared addTarget:self action:@selector(btnShared) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar_Shared = [[UIBarButtonItem alloc]initWithCustomView:button_Shared];
    self.navigationItem.rightBarButtonItem = bar_Shared;
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
}


//返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//分享事件
- (void) btnShared
{
    JGShareView *shareView;
    NSString *content;
    switch (self.type) {
        case k_Astigma://散光分享
        {
            content = [NSString stringWithFormat:@"我在云e生APP上做了【散光测试】，大家一起来测试吧!下面放下载链接%@",k_ShareURL];
            shareView =  [JGShareView shareViewWithTitle:@"散光测试" content:content imgUrlStr:k_ShareImage ulrStr:k_ShareURL contentView:self.view shareImagePath:nil];
//            share_view.shareTitle = @"散光测试";
//            share_view.shareContent = @"我在云e生APP上做了【散光测试】，大家一起来测试吧!下面放下载链接";
        }
            break;
        case k_Blindness://色盲分享
        {
            content = [NSString stringWithFormat:@"我在云e生APP上做了【色盲测试】，大家一起来测试吧!下面放下载链接%@",k_ShareURL];
            shareView = [JGShareView shareViewWithTitle:@"色盲测试" content:content imgUrlStr:k_ShareImage ulrStr:k_ShareURL contentView:self.view shareImagePath:nil];
//            share_view.shareTitle = @"色盲测试";
//            share_view.shareContent = @"我在云e生APP上做了【色盲测试】，大家一起来测试吧!下面放下载链接";
        }
            break;
        case k_Hearing://听力分享
        {
            content = [NSString stringWithFormat:@"我在云e生APP上做了【听力测试】，大家一起来测试吧!下面放下载链接%@",k_ShareURL];
            shareView = [JGShareView shareViewWithTitle:@"听力测试" content:content imgUrlStr:k_ShareImage ulrStr:k_ShareURL contentView:self.view shareImagePath:nil];
//            share_view.shareTitle = @"听力测试";
//            share_view.shareContent = @"我在云e生APP上做了【听力测试】，大家一起来测试吧!下面放下载链接";
        }
            break;
        default:
            break;
    }
    [shareView show];
}
@end
