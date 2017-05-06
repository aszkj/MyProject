//
//  examineResultViewController.m
//  jingGang
//
//  Created by thinker on 15/7/21.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "examineResultViewController.h"
#import "PublicInfo.h"
#import "JGShareView.h"
#import "VApiManager.h"
#import "PhysicalSaveRequest.h"
#import "GlobeObject.h"
#import "AppDelegate.h"
#import "MJRefresh.h"


@interface examineResultViewController ()
{
    VApiManager * _manager; //网络请求
}
//视力结果数值
@property (weak, nonatomic) IBOutlet UILabel *eyeValueLabel;
//保存数据提示
@property (weak, nonatomic) IBOutlet UILabel *saveDataLabel;
//中间Label
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
//头图片
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@end

@implementation examineResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self saveData];
    [self setResultData];
}
- (void) setResultData
{
    self.centerLabel.adjustsFontSizeToFitWidth = YES;
    self.resultLabel.adjustsFontSizeToFitWidth = YES;
    switch (self.type) {
        case k_Eye:
            [self setEyeData];
            break;
        case k_Blindnes:
            [self setBlindnessData];
            break;
        default:
            break;
    }
    
}
- (void) setBlindnessData
{
    self.eyeValueLabel.text = [NSString stringWithFormat:@"%ld",self.blindnessValue * 20];
//    self.resultLabel.text = [NSString stringWithFormat:@"%ld",self.blindnessValue * 20];
    self.resultLabel.adjustsFontSizeToFitWidth = YES;
    switch (self.blindnessValue) {
        case 0:
        {
            self.centerLabel.text = @"要多次测试确定数值，可以通过健康方式弥补自己不足。";
            self.resultLabel.text = @"完全分不清状态";
        }
            break;
        case 1:
        {
            self.centerLabel.text = @"要不定期检查和测试，纠正自己色值的感官，提升测试值。";
            self.resultLabel.text = @"重度分不清状态";
        }
            break;
        case 2:
        {
            self.centerLabel.text = @"在疲劳过度，或者工作环境造成，要改善光线和生活环境。";
            self.resultLabel.text = @"中度分不清状态";
        }
            break;
        case 3:
        {
            self.centerLabel.text = @"不注意休息，长期损害辨别力，要调整休息时间。";
            self.resultLabel.text = @"轻度分不清状态";
        }
            break;
        case 4:
        {
            self.centerLabel.text = @"在一定时间内，学会释放眼睛的光线，调和眼光色值的对比度。";
            self.resultLabel.text = @"稍微分不清状态";
        }
            break;
        case 5:
        {
            self.centerLabel.text = @"继续保持眼球血液循环，以及视网膜的清晰度。";
            self.resultLabel.text = @"正常清晰状态";
            self.titleImageView.image = [UIImage imageNamed:@"test_smile"];
        }
            break;
        default:
            break;
    }
    
}
- (void) setEyeData
{
    if ([self.eyeValue floatValue] <= 4.0)
    {
        self.centerLabel.text = @"要早期检查治疗，以及每年做一次眼底检查。如病理性近视、近视眼家族、高度近视患者等";
        self.resultLabel.text = @"重度近视视力在650度以上";
    }
    else if ([self.eyeValue floatValue] <= 4.5)
    {
        self.centerLabel.text = @"可恢复调节与集合的平衡，缓解视疲劳，预防或矫正斜视或弱视，减低屈光参差.如佩戴眼睛、手术治疗、药物治疗等。";
        self.resultLabel.text = @"中度近视视力在300~650度左右";
    }
    else if ([self.eyeValue floatValue] <= 4.9 )
    {
        self.centerLabel.text = @"缓解视疲劳，改善光环境。如雾视法、双眼合像法及合像增视仪、远眺法、睫状肌锻炼法等均可试用";
        self.resultLabel.text = @"轻微近视视力在100~250度左右";
    }
    else
    {
        self.titleImageView.image = [UIImage imageNamed:@"test_smile"];
        self.centerLabel.text = @"继续保持眼保健操习惯，养成经常测视力的好方式。";
        self.resultLabel.text = @"视力正常";
    }
}
- (void) saveData
{
    self.saveDataLabel.layer.cornerRadius = 5;
    _manager = [[VApiManager alloc ]init];
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia"];
    NSDate *date = [NSDate date];
    
    PhysicalSaveRequest *saveRequest = [[PhysicalSaveRequest alloc] init:GetToken];
    switch (self.type) {
        case k_Eye:
        {
            saveRequest.api_type = @(2);
            saveRequest.api_maxValue = [NSNumber numberWithFloat:[self.eyeValue floatValue]];
            saveRequest.api_minValue = [NSNumber numberWithFloat:[self.eyeValue floatValue]];
        }
            break;
        case k_Blindnes:
        {
            saveRequest.api_type = @(3);
            saveRequest.api_maxValue = @(self.blindnessValue > 3 ? 1 : 2);
        }
            break;
        default:
            break;
    }
    
    saveRequest.api_time = [formatter stringFromDate:date];
//    saveRequest.api_middleValue = [NSNumber numberWithFloat:[self.eyeValue floatValue]];
    NSLog(@"----%@----%@----%@",GetToken,@(2),saveRequest.api_maxValue);
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
        case k_Blindnes:
            l.text = @"色盲测试结果";
            break;
        case k_Eye:
            l.text = @"视力测试结果";
            break;
        default:
            break;
    }
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;
}
//初始化UI
- (void) initUI
{
    self.saveDataLabel.layer.cornerRadius = 5;
    self.eyeValueLabel.text = self.eyeValue;
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
        case k_Blindnes:
        {
            content = [NSString stringWithFormat:@"我在云e生APP上做了【色盲测试】，大家一起来测试吧!下面放下载链接%@",k_ShareURL];
            shareView = [JGShareView shareViewWithTitle:@"色盲测试" content:content imgUrlStr:k_ShareImage ulrStr:k_ShareURL contentView:self.view shareImagePath:nil];
        }
            break;
        case k_Eye:
        {
            content = [NSString stringWithFormat:@"我在云e生APP上做了【视力测试】，大家一起来测试吧!下面放下载链接%@",k_ShareURL];
            shareView = [JGShareView shareViewWithTitle:@"视力测试" content:content imgUrlStr:k_ShareImage ulrStr:k_ShareURL contentView:self.view shareImagePath:nil];
        }
            break;
        default:
            break;
    }
    [shareView show];
}

@end
